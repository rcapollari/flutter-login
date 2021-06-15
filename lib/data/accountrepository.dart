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
}