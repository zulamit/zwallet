import 'package:sqflite/sqflite.dart';
import 'package:warp/backup.dart';
import 'coin/coins.dart';

class DbReader {
  Database db;
  int id;
  DbReader(AccountId account): this.init(getCoin(account.coin).db, account.id);
  DbReader.init(this.db, this.id);

  Future<Balances> getBalance(int confirmHeight) async {
    final balance = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT SUM(value) AS value FROM received_notes WHERE account = ?1 AND (spent IS NULL OR spent = 0)",
        [id])) ?? 0;
    final shieldedBalance = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT SUM(value) AS value FROM received_notes WHERE account = ?1 AND spent IS NULL",
        [id])) ?? 0;
    final unconfirmedBalance = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT SUM(value) AS value FROM received_notes WHERE account = ?1 AND spent = 0",
        [id])) ?? 0;
    final underConfirmedBalance = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT SUM(value) AS value FROM received_notes WHERE account = ?1 AND height > ?2",
        [id, confirmHeight])) ?? 0;
    final excludedBalance = Sqflite.firstIntValue(await db.rawQuery(
        "SELECT SUM(value) FROM received_notes WHERE account = ?1 AND spent IS NULL "
            "AND height <= ?2 AND excluded",
        [id, confirmHeight])) ?? 0;

    return Balances(balance, shieldedBalance, unconfirmedBalance, underConfirmedBalance, excludedBalance);
  }
}

class Balances {
  final int balance;
  final int shieldedBalance;
  final int unconfirmedBalance;
  final int underConfirmedBalance;
  final int excludedBalance;

  Balances(this.balance, this.shieldedBalance, this.unconfirmedBalance, this.underConfirmedBalance, this.excludedBalance);
}