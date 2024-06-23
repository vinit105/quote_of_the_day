
import 'dart:async';

import 'package:path/path.dart';
import 'package:quote_of_the_day/db/quote.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseServices{
  static Database? _db;
  static final DatabaseServices instance = DatabaseServices._constructor();


  final String _tableName = "quotes";
  final String _idColumnName = "id";
  final String _contentColumnName = "content";
  final String _authorColumnName = "author";

  DatabaseServices._constructor();

  Future<Database> get database async{
    if(_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async{
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $_tableName(
        $_idColumnName TEXT PRIMARY KEY,
        $_contentColumnName TEXT NOT NULL,
        $_authorColumnName TEXT NOT NULL
        )
        ''');
      },
    );
    return database;
  }

  void addTask(String id, String content,String author,) async{
    final db = await database;
    await db.insert(_tableName, {
      _idColumnName : id,
      _contentColumnName : content,
      _authorColumnName : author,
    });
  }

  Future<List<Quote>> getTasks() async{
    final db = await database;
    final data = await db.query(_tableName);
    List<Quote> q = data.map((e) => Quote(id: e["id"] as String ,  content: e["content"] as String , author: e["author"] as String,)).toList();

     return q;
  }


  void delete(String id) async {
    final db = await database;
    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [
        id,
      ]
    );
  }


}































