import 'dart:async';

import 'package:habittracker/models/habit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._instance();

  DatabaseService._instance();

  static Database? _db;

  String table = 'habit_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDesc = 'description';
  String colStatus = 'status';
  String colDone = 'done';

  Future<Database?> get database async {
    _db ??= await initDB();
    return _db;
  }

  Future<Database> initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}./habit_list.db';
    var database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT,$colDesc TEXT,$colStatus INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getMapLists() async {
    Database? db = await database;
    final List<Map<String, dynamic>> result = await db!.query(table);
    return result;
  }

  Future<List<Habit>> getHabitLists() async {
    final List<Map<String, dynamic>> mapLists = await getMapLists();
    final List<Habit> habitLists = [];

    for (var todo in mapLists) {
      habitLists.add(Habit.fromMap(todo));
    }
    return habitLists;
  }

  Future<int> insertHabit(Habit habit) async {
    Database? db = await database;

    final int id = await db!.insert(table, habit.toMap());
    return id;
  }

  Future<int> deleteHabit(int? id) async {
    Database? db = await database;
    final int result = await db!.delete(
      table,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<int> updateHabit(Habit habit) async {
    Database? db = await database;
    final int result = await db!.update(
      table,
      habit.toMap(),
      where: '$colId = ?',
      whereArgs: [habit.id],
    );
    return result;
  }

  Future<int> deleteAll() async {
    Database? db = await database;
    final int result = await db!.delete(table);
    return result;
  }
}
