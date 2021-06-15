import 'dart:io';
import 'package:path/path.dart';
import 'package:synchronized/synchronized.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  static const String CreateErrorLog =
      'CREATE TABLE error_log (uuid STRING (36) PRIMARY KEY NOT NULL, physicaldeviceid STRING (16) NOT NULL, message VARCHAR (4000) NOT NULL, stacktrace VARCHAR (4000), statuscode INTEGER, timeoccurred DATETIME NOT NULL, syncstate CHAR (1), errortype VARCHAR (25) )';

  static const String CreateErrorLogIdx =
      'CREATE UNIQUE INDEX idx_uuid_error_log ON error_log (uuid)';

  static const String CreateAccountMaster =
      'CREATE TABLE account_master (formId INTEGER PRIMARY KEY NOT NULL UNIQUE, title TEXT NOT NULL, json TEXT NOT NULL, dateadded DATETIME NOT NULL, test BOOLEAN NOT NULL)';

  static const String CreateAccountMasterIdx =
      'CREATE INDEX idx_formId_account_master ON account_master(formId)';

  static const String CreateAccountData =
      'CREATE TABLE survey_data (uuid STRING (36) PRIMARY KEY NOT NULL, physicaldeviceid STRING (16) NOT NULL, respondentId INTEGER, eventInstanceId INTEGER, formId INTEGER NOT NULL, title TEXT NOT NULL, data TEXT NOT NULL, datesaved DATETIME NOT NULL, syncstate CHAR (1))';

  static const String CreateAccountDataIdx =
      'CREATE INDEX idx_uuid_account_data ON account_data (uuid);';

  static const String UpdateAccountDataRespondent =
      'ALTER TABLE account_data ADD COLUMN respondentId INTEGER;';

  static const String UpdateAccountDateEventInstance =
      'ALTER TABLE account_data ADD COLUMN eventInstanceId INTEGER;';

  static const String CreateEventMaster =
      'CREATE TABLE event_master (id INTEGER PRIMARY KEY NOT NULL UNIQUE,  displayName TEXT NOT NULL,  eventInstances TEXT NOT NULL, respondentFormMapping TEXT NOT NULL);';

  static const String CreateRespondentMaster =
      'CREATE TABLE respondent_master (id INTEGER PRIMARY KEY NOT NULL UNIQUE,  displayName TEXT NOT NULL);';

  static const int _dbVersion = 7;
  final Lock _lock = Lock();

  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      await _lock.synchronized(() async {
        _db = await initDb();
      });
    }

    return _db;
  }

  Future<Database> initDb() async {
    final String databasesPath = await getDatabasesPath();
    final String path = join(databasesPath, 'users.db');

    // make sure the directory exists
    try {
      await Directory(databasesPath).create(recursive: true);
    } catch (_) {}

    // open the database
    final Database db = await openDatabase(path,
        version: _dbVersion,
        onCreate: _onCreate,
        onConfigure: _onConfigure,
        onUpgrade: _onUpgrade);
    return db;
  }

  Future<void> close() async {
    return _db.close();
  }

  Future<void> _onCreate(Database db, int version) async {
    print('Creating tables for version $version');
    await db.execute(CreateErrorLog);
    await db.execute(CreateErrorLogIdx);

    await db.execute(CreateAccountMaster);
    await db.execute(CreateAccountMasterIdx);

    await db.execute(CreateAccountData);
    await db.execute(CreateAccountDataIdx);

    await db.execute(CreateEventMaster);
    await db.execute(CreateRespondentMaster);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      print(
          'Upgrading tables and idexes from version $oldVersion to $newVersion');

      if (oldVersion < 4) {
        await db.execute(CreateEventMaster);
      }
      if (oldVersion < 5) {
        await db.execute(CreateRespondentMaster);
      }
      if (oldVersion < 6) {
        await db.execute(UpdateAccountDataRespondent);
      }
      if(oldVersion <7){
        await db.execute(UpdateAccountDateEventInstance);
      }
    }
  }

  Future<void> _onConfigure(Database db) async {}

}