import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../utils/app_strings.dart';

class DatabaseHelper {
  final _dbName = 'dbJacksi.db';
  final _dbVersion = 1;

  Database? _database;

  Future<Database?> get database async{
    if(_database != null) return _database;
    _database = await _initiateDatabase();
    return _database;
  }

  Future<Database> _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${AppStrings.tableProduct}(
        ${AppStrings.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${AppStrings.columnProductName} TEXT,
        ${AppStrings.columnStoreName} TEXT,
        ${AppStrings.columnPrice} FLOAT,
        ${AppStrings.columnCategory} INTEGER
      )
      ''');

    await db.execute('''
      CREATE TABLE ${AppStrings.tableImage} (
        ${AppStrings.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${AppStrings.columnImagePath} TEXT,
        ${AppStrings.columnProductIdFK} INTEGER,
        FOREIGN KEY (${AppStrings.columnProductIdFK}) REFERENCES ${AppStrings.tableProduct}(${AppStrings.columnId})
      )
      ''');
  }

  Future close() async {
    final db = (await database)!;
    db.close();
  }
}
