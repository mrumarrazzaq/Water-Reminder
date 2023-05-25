import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

const String tableName = 'WaterReminders';

class SQLHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        time TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'Collection.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  static Future<int> createRecord({
    required String time,
  }) async {
    final db = await SQLHelper.db();

    final data = {'time': time};
    final id = await db.insert(tableName, data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getRecords() async {
    final db = await SQLHelper.db();
    return db.query(tableName, orderBy: "id DESC");
  }

  static Future<List<Map<String, dynamic>>> getRecord(int id) async {
    final db = await SQLHelper.db();
    return db.query(tableName, where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateRecord(
      {required int id, required String time}) async {
    final db = await SQLHelper.db();

    final data = {'time': time, 'createdAt': DateTime.now().toString()};

    final result =
        await db.update(tableName, data, where: "id = ?", whereArgs: [id]);
    return result;
  }

  static Future<void> deleteRecord(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete(tableName, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  static Future<void> dropTableIfExists({required String tableName}) async {
    final db = await SQLHelper.db();
    try {
      await db.delete(tableName);
      await db.close();
      print('--------------------------------');
      print('Table Drop successfully : $tableName');
      await SQLHelper.db();
    } catch (err) {
      debugPrint("Something went wrong when deleting an table: $err");
    }
  }
}
