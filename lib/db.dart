import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:warp/backup.dart';
import 'package:warp/store.dart';
import 'package:warp_api/warp_api.dart';
import 'coin/coins.dart';
import 'main.dart';

final DateFormat noteDateFormat = DateFormat("yy-MM-dd HH:mm");
final DateFormat txDateFormat = DateFormat("MM-dd HH:mm");

class DbReader {
  int coin;
  int id;
  Database db;

  DbReader(AccountId account): this.init(account.coin, account.id, getCoin(account.coin).db);
  DbReader.init(this.coin, this.id, this.db);

  Future<Balances> getBalance(int confirmHeight) async {
    final balance = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT SUM(value) AS value FROM received_notes WHERE account = ?1 AND (spent IS NULL OR spent = 0)",
        [id])) ?? 0;
    final shieldedBalance = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT SUM(value) AS value FROM received_notes WHERE account = ?1 AND spent IS NULL",
        [id])) ?? 0;
    final unconfirmedSpentBalance = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT SUM(value) AS value FROM received_notes WHERE account = ?1 AND spent = 0",
        [id])) ?? 0;
    final underConfirmedBalance = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT SUM(value) AS value FROM received_notes WHERE account = ?1 AND height > ?2",
        [id, confirmHeight])) ?? 0;
    final excludedBalance = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT SUM(value) FROM received_notes WHERE account = ?1 AND spent IS NULL "
            "AND height <= ?2 AND excluded",
        [id, confirmHeight])) ?? 0;
    final unconfirmedBalance = await WarpApi.mempoolSync(coin);

    return Balances(balance, shieldedBalance, unconfirmedSpentBalance, underConfirmedBalance, excludedBalance, unconfirmedBalance);
  }

  Future<List<Note>> getNotes() async {
    final List<Map> res = await db.rawQuery(
        "SELECT n.id_note, n.height, n.value, t.timestamp, n.excluded, n.spent FROM received_notes n, transactions t "
            "WHERE n.account = ?1 AND (n.spent IS NULL OR n.spent = 0) "
            "AND n.tx = t.id_tx ORDER BY n.height DESC",
        [id]);
    final notes = res.map((row) {
      final id = row['id_note'];
      final height = row['height'];
      final timestamp = noteDateFormat
          .format(DateTime.fromMillisecondsSinceEpoch(row['timestamp'] * 1000));
      final excluded = (row['excluded'] ?? 0) != 0;
      final spent = row['spent'] == 0;
      return Note(
          id, height, timestamp, row['value'] / ZECUNIT, excluded, spent);
    }).toList();
    print("NOTES ${notes.length}");
    return notes;
  }
}

class Balances {
  final int balance;
  final int shieldedBalance;
  final int unconfirmedSpentBalance;
  final int underConfirmedBalance;
  final int excludedBalance;
  final int unconfirmedBalance;

  Balances(this.balance, this.shieldedBalance, this.unconfirmedSpentBalance, this.underConfirmedBalance, this.excludedBalance, this.unconfirmedBalance);
  static Balances zero = Balances(0, 0, 0, 0, 0, 0);
}