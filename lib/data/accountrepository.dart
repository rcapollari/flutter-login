import 'dart:convert';
import 'package:sqflite/sqflite.dart';

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