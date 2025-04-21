import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class MusicDatabaseHelper {
  static MusicDatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  String MusicTable = 'music_table';
  String? id = 'id';
  String? title = 'title';
  String? subtitle = 'subtitle';
  String? audio = 'audio';
  String? image = 'image';
  String? subCategoryId = 'subCategoryId';
  String? subCategoryName = 'subCategoryName';
  String? lyrics = 'lyrics';

  MusicDatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  MusicDatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper =
          MusicDatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
  }

  Future<MusicDatabaseHelper> get databaseHelper async {
    if (_databaseHelper == null) {
      _databaseHelper =
          MusicDatabaseHelper._createInstance(); // This is executed only once, singleton object
    }
    return _databaseHelper!;
  }

  String get gettablename => MusicTable;

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
  
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'music.db';
    print("DataBasePath: $path");

  
    var notesDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $MusicTable($id INTEGER PRIMARY KEY AUTOINCREMENT, $title TEXT, '
      '$subtitle TEXT, $audio TEXT, $image TEXT, $subCategoryId TEXT, '
      '$subCategoryName TEXT, $lyrics TEXT)',
    );
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getMusicMapList() async {
    Database db = await this.database;

    //		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(MusicTable, orderBy: '$id ASC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  // Future<int> insertNote(Note note) async {
  //   Database db = await this.database;
  //   var result = await db.insert(noteTable, note.toMap());
  //   return result;
  // }

  // // Update Operation: Update a Note object and save it to database
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

  // // Delete Operation: Delete a Note object from database
  // Future<int> deleteNote(int id) async {
  //   var db = await this.database;
  //   int result = await db.rawDelete(
  //     'DELETE FROM $noteTable WHERE $colId = $id',
  //   );
  //   return result;
  // }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery(
      'SELECT COUNT (*) from $MusicTable',
    );
    int? result = Sqflite.firstIntValue(x);
    return result ?? 0;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  //   Future<List<Note>> getNoteList() async {
  //     var noteMapList = await getNoteMapList(); // Get 'Map List' from database
  //     int count =
  //         noteMapList.length; // Count the number of map entries in db table

  //     List<Note> noteList = List<Note>();
  //     // For loop to create a 'Note List' from a 'Map List'
  //     for (int i = 0; i < count; i++) {
  //       noteList.add(Note.fromMapObject(noteMapList[i]));
  //     }

  //     return noteList;
  //   }
}
