import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:warp/coin/coins.dart';
import 'package:mobx/mobx.dart';
import 'package:warp/coin/zcash.dart';
import 'package:warp/db.dart';
import 'package:warp_api/warp_api.dart';

import 'backup.dart';
import 'coin/coin.dart';
import 'main.dart';
import 'store.dart';

part 'accounts.g.dart';

final Account emptyAccount = Account(0, 0, "", "", 0, 0, null);

class AccountManager2 = _AccountManager2 with _$AccountManager2;

abstract class _AccountManager2 with Store {
  @observable int epoch = 0;
  List<Account> list = [];

  @action
  Future<void> refresh() async {
    List<Account> _list = [];
    _list.addAll(await _getList(0));
    _list.addAll(await _getList(1));
    list = _list;
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

  @action
  Future<void> delete(int coin, int id) async {
    WarpApi.deleteAccount(coin, id);
    if (active.coin == coin && active.id == id)
      active.reset();
  }

  Account get(int coin, int id) => list.firstWhere((e) => e.coin == coin && e.id == id, orElse: () => emptyAccount);

  static Future<List<Account>> _getList(int coin) async {
    final c = getCoin(coin);
    final db = c.db;
    List<Account> accounts = [];
    final List<Map> res0 = await db.rawQuery("SELECT name FROM accounts", []);

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

class ActiveAccount = _ActiveAccount with _$ActiveAccount;

abstract class _ActiveAccount with Store {
  @observable
  int dataEpoch = 0;

  int coin = 0;
  int id = 0;

  Account account = emptyAccount;
  CoinBase coinDef = ZcashCoin();
  bool canPay = false;
  @observable Balances balances = Balances.zero;
  String taddress = "";
  int tbalance = 0;
  @observable List<Note> notes = [];
  List<Tx> txs = [];
  List<Spending> spendings = [];
  List<TimeSeriesPoint<double>> accountBalances = [];
  List<PnL> pnls = [];

  @observable
  bool showTAddr = false;

  @observable
  SortConfig noteSortConfig = SortConfig("", SortOrder.Unsorted);

  @observable
  SortConfig txSortConfig = SortConfig("", SortOrder.Unsorted);

  @observable
  int pnlSeriesIndex = 0;

  @observable
  bool pnlDesc = false;

  @action
  Future<void> restore() async {
    final prefs = await SharedPreferences.getInstance();
    coin = prefs.getInt('coin') ?? 0;
    id = prefs.getInt('account') ?? 0;
    setActiveAccount(AccountId(coin, id));
  }

  void reset() {
    setActiveAccount(AccountId(0, 0));
  }

  @action
  Future<void> setActiveAccount(AccountId accountId) async {
    coin = accountId.coin;
    id = accountId.id;

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('coin', coin);
    prefs.setInt('account', id);

    coinDef = getCoin(coin);
    final db = coinDef.db;

    account = accounts.get(coin, id);

    if (id > 0) {
      final List<Map> res1 = await db.rawQuery(
          "SELECT address FROM taddrs WHERE account = ?1", [id]);
      taddress = res1.isNotEmpty ? res1[0]['address'] : "";

      final List<Map> res2 = await db.rawQuery(
          "SELECT sk FROM accounts WHERE id_account = ?1", [id]);
      canPay = res2.isNotEmpty && res2[0]['sk'] != null;
    }

    showTAddr = false;
    balances = Balances.zero;
    WarpApi.setMempoolAccount(coin, id);

    await update();
    // await _fetchData(db, account, true);
  }

  @action
  void toggleShowTAddr() {
    showTAddr = !showTAddr;
  }

  @action
  void updateTBalance() {
    tbalance = WarpApi.getTBalance(coin, id);
  }

  @action
  Future<void> updateBalances() async {
    final dbr = DbReader(AccountId(coin, id));
    balances = await dbr.getBalance(syncStatus.confirmHeight);
  }

  @action
  Future<void> update() async {
    await updateBalances();
    updateTBalance();
    final dbr = DbReader(AccountId(coin, id));
    notes = await dbr.getNotes();
    dataEpoch += 1;
  }

  String newAddress() {
    return WarpApi.newAddress(coin, id);
  }

  @computed
  List<Note> get sortedNotes {
    var notes2 = [...notes];
    switch (noteSortConfig.field) {
      case "time":
        return _sort(notes2, (Note note) => note.height, noteSortConfig.order);
      case "amount":
        return _sort(notes2, (Note note) => note.value, noteSortConfig.order);
    }
    return notes2;
  }

  @action
  void sortNotes(String field) {
    noteSortConfig = noteSortConfig.sortOn(field);
  }

  List<C> _sort<C extends HasHeight, T extends Comparable>(
      List<C> items, T Function(C) project, SortOrder order) {
    switch (order) {
      case SortOrder.Ascending:
        items.sort((a, b) => project(a).compareTo(project(b)));
        break;
      case SortOrder.Descending:
        items.sort((a, b) => -project(a).compareTo(project(b)));
        break;
      case SortOrder.Unsorted:
        items.sort((a, b) => -a.height.compareTo(b.height));
        break;
    }
    return items;
  }

  @action
  Future<void> excludeNote(Note note) async {
    await coinDef.db.execute(
        "UPDATE received_notes SET excluded = ?2 WHERE id_note = ?1",
        [note.id, note.excluded]);
  }

  @action
  Future<void> invertExcludedNotes() async {
    await coinDef.db.execute(
        "UPDATE received_notes SET excluded = NOT(COALESCE(excluded, 0)) WHERE account = ?1",
        [active.id]);
    notes = notes.map((n) => n.invertExcluded).toList();
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
