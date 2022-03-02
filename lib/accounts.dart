import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:warp/coin/coins.dart';
import 'package:mobx/mobx.dart';
import 'package:warp_api/warp_api.dart';

import 'backup.dart';
import 'store.dart';

part 'accounts.g.dart';

class AccountManager2 = _AccountManager2 with _$AccountManager2;

abstract class _AccountManager2 with Store {
  @observable int epoch = 0;
  List<Account> list = [];

  @action
  Future<void> refresh() async {
    list.clear();
    list.addAll(await _list(0));
    list.addAll(await _list(1));
    epoch += 1;
  }

  @action
  Future<void> updateTBalance() async {
    for (var a in list) {
      final tbalance = await WarpApi.getTBalanceAsync(a.coin, a.id);
      a.tbalance = tbalance;
    }
    epoch += 1;
  }

  static Future<List<Account>> _list(int coin) async {
    final c = getCoin(coin);
    final db = c.db;
    List<Account> accounts = [];
    final List<Map> res0 = await db.rawQuery("SELECT name FROM accounts", []);
    for (var r in res0) {
      print(r['name']);
    }

    final List<Map> res = await db.rawQuery(
        "WITH notes AS (SELECT a.id_account, a.name, a.address, CASE WHEN r.spent IS NULL THEN r.value ELSE 0 END AS nv FROM accounts a LEFT JOIN received_notes r ON a.id_account = r.account),"
            "accounts2 AS (SELECT id_account, name, address, COALESCE(sum(nv), 0) AS balance FROM notes GROUP by id_account) "
            "SELECT a.id_account, a.name, a.address, a.balance, ss.idx, ss.secret, ss.participants, ss.threshold FROM accounts2 a LEFT JOIN secret_shares ss ON a.id_account = ss.account",
        []);
    for (var r in res) {
      final int id = r['id_account'];
      // final shareInfo = r['secret'] != null
      //     ? ShareInfo(
      //     r['idx'], r['threshold'], r['participants'], r['secret'])
      //     : null; // TODO: Multisig
      final account = Account(coin, // TODO
          r['id_account'], r['name'], r['address'], r['balance'], 0, null);
      accounts.add(account);
    }
    return accounts;
  }
}

Future<Backup> getBackup(AccountId account) async {
  final c = getCoin(account.coin);
  final db = c.db;
  final List<Map> res = await db.rawQuery(
      "SELECT name, seed, sk, ivk FROM accounts WHERE id_account = ?1",
      [account.id]);
  if (res.isEmpty) throw Exception("Account N/A");
  // final share = await getShareInfo(account); // Multisig
  final row = res[0];
  final name = row['name'];
  final seed = row['seed'];
  final sk = row['sk'];
  final ivk = row['ivk'];
  int type = 0;
  if (seed != null)
    type = 0;
  else if (sk != null)
    type = 1;
  else if (ivk != null) type = 2;
  return Backup(type, name, seed, sk, ivk, null);
}
