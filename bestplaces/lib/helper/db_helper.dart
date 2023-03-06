import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  //creting database inside phone storage
  static Future<Database> database() async {
    //path to store database(basically in app folder)
    final dbPath = await sql.getDatabasesPath();
    //providing path to open database and also creating places.dp file inside the databse folder
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT)');
    }, version: 1);
  }

  static Future<void> insert(
      {required String table, required Map<String, dynamic> data}) async {
    //accessing database
    final db = await DBHelper.database();
    //inserting values in database
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    ); //conflict replace override data which already present
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    //accessing database
    final db = await DBHelper.database();
    return db.query(table);
  }
}
