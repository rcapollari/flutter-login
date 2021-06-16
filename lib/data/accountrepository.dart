import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:login_form/data/dbprovider.dart';

abstract class AccountRepository {
  Future<void> insertAccountMasterRecords(List<dynamic> accountMasterData);

  Future<void> saveAccountAnswers(
  {
    int formId,
    String firstname,
    String lastname,
    String email,
    String password,
    Map<String, dynamic> data});
}

class AccountRepositoryImpl extends AccountRepository {
  final String insertSql =
      'INSERT INTO account_master(id, firstname, lastname, email, password) values (?, ?, ?, ?, ?) ';

  final String updateSql =
      'UPDATE account_master SET firstname = ?, lastname = ?, email = ?, password = ? WHERE id = ?';

  final String selectSql =
      'SELECT id from account_master WHERE id = ? ';

  final String deleteSql =
      'DELETE FROM account_master';

  @override
  Future<void> clear() async {
    final DbProvider dbp = DbProvider();
    final Database dbClient = await dbp.db;

    await dbClient.rawUpdate('UPDATE account_master SET syncstate = null');
  }

  @override
  Future<List<AccountMaster>> getAccount() async {
    final DbProvider dbp = DbProvider();
    final Database dbClient = await dbp.db;
    final List<Map<dynamic, dynamic>> results =
        await dbClient.rawQuery(selectAllSql);
  }
}