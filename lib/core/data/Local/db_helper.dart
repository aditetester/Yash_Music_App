import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class MusicPlayerDBHelper {
  static MusicPlayerDBHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  String _musicPlayerTable = 'music_table';
  String _categoryPlayListTable = 'category_playlist_table';
  String _musicPlayListTable = 'musicplaylist_table';
  String _recentPlayListTable = 'recentPlayList_table';

  String? id = 'id';
  String? title = 'title';
  String? subTitle = 'subTitle';
  String? audio = 'audio';
  String? image = 'image';
  String? subCategoryId = 'subCategoryId';
  String? subCategoryName = 'subCategoryName';
  String? lyrics = 'lyrics';

  String? localId = "localId";

  String? recentId = 'recentId';

  String? categoryId = "categoryId";
  String? categoryName = "categoryName";
  String? totalSongs = "totalSongs";

  MusicPlayerDBHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  MusicPlayerDBHelper() {
    if (_databaseHelper == null) {
      _databaseHelper =
          MusicPlayerDBHelper._createInstance(); // This is executed only once, singleton object
    }
  }

  Future<MusicPlayerDBHelper> get databaseHelper async {
    if (_databaseHelper == null) {
      _databaseHelper =
          MusicPlayerDBHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper!;
  }

  String get getMusicPlayerTableName => _musicPlayerTable;

  String get getCategoryPlayListTable => _categoryPlayListTable;

  String get getMusicPlayListTable => _musicPlayListTable;

  String get getRecentPlayListTable => _recentPlayListTable;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'music.db';

    // print("DataBasePath: $path");

    var musicDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return musicDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $_musicPlayerTable($id INTEGER PRIMARY KEY AUTOINCREMENT, $title TEXT, '
      '$subTitle TEXT, $audio TEXT, $image TEXT, $subCategoryId TEXT, '
      '$subCategoryName TEXT, $lyrics TEXT)',
    );
    await db.execute(
      'CREATE TABLE $_categoryPlayListTable($categoryId INTEGER PRIMARY KEY AUTOINCREMENT, $categoryName TEXT, $totalSongs TEXT)',
    );
    await db.execute(
      'CREATE TABLE $_musicPlayListTable($localId INTEGER PRIMARY KEY AUTOINCREMENT, $id TEXT, $title TEXT, '
      '$subTitle TEXT, $audio TEXT, $image TEXT, $subCategoryId TEXT, '
      '$subCategoryName TEXT, $lyrics TEXT)',
    );

    await db.execute(
      'CREATE TABLE $_recentPlayListTable($recentId INTEGER PRIMARY KEY AUTOINCREMENT , $id TEXT , $title TEXT, '
      '$subTitle TEXT, $audio TEXT, $image TEXT, $subCategoryId TEXT, '
      '$subCategoryName TEXT, $lyrics TEXT )',
    );
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getMusicMapList() async {
    Database db = await this.database;
    //		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(_musicPlayerTable, orderBy: '$id ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getCategoryPlayListMapList() async {
    Database db = await this.database;
    //		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(
      _categoryPlayListTable,
      orderBy: '$categoryId ASC',
    );
    return result;
  }

  Future<List<Map<String, dynamic>>> getPlayListMapList() async {
    Database db = await this.database;
    //		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(_musicPlayListTable, orderBy: '$localId ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getRecentPlayListMapList() async {
    Database db = await this.database;
    //		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(
      _recentPlayListTable,
      orderBy: '$recentId DESC',
    );
    return result;
  }

  // Future<int> updateNote(Note note) async {
  //   var db = await this.database;
  //   var result = await db.update(
  //     noteTable,
  //     note.toMap(),
  //     where: '$colId = ?',
  //     whereArgs: [note.id],
  //   );
  //   return result;
  // }

  // Future<int> deleteNote(int id) async {
  //   var db = await this.database;
  //   int result = await db.rawDelete(
  //     'DELETE FROM $noteTable WHERE $colId = $id',
  //   );
  //   return result;
  // }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery(
      'SELECT COUNT (*) from $_musicPlayerTable',
    );
    int? result = Sqflite.firstIntValue(x);
    return result ?? 0;
  }
}
