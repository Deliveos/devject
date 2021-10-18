import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseProvider {
  DatabaseProvider._privateConstructor();
  static const String _dbName = "projetex.db";
  static const int _dbVersion = 1;

  static final DatabaseProvider instance = DatabaseProvider._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initiateDatabase();
    
    return _database!;
  }

  _initiateDatabase () async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  _onCreate(Database database, int version) async {
    database.rawQuery('''
      CREATE TABLE user(
        id INTEGER,
        name VARCHAR(255) NOT NULL,
        nickname VARCHAR(255) NOT NULL,
        token TEXT
      );
    ''');
  }
}