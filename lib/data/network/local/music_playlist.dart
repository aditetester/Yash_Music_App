import 'dart:async';
import 'package:boilerplate_new_version/core/data/Local/db_helper.dart';
import 'package:boilerplate_new_version/domain/entity/categories/category_list.dart';
import 'package:boilerplate_new_version/domain/entity/category_play_list/category.dart';
import 'package:boilerplate_new_version/domain/entity/category_play_list/category_play_list.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';
import 'package:sqflite/sqflite.dart';

class LocalMusicPlayList {
  final MusicPlayerDBHelper _dioClient;
  MusicListModule module = MusicListModule();
  CategoryPlayListModule module2 = CategoryPlayListModule();

  LocalMusicPlayList(this._dioClient);

  Future<AllMusicList> getMusicPlayList() async {
    try {
      await _dioClient.initializeDatabase();
      final res = await _dioClient.getPlayListMapList();

      return AllMusicList.fromJson3(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> insertMusicPlayList(MusicListModule data) async {
    Database db = await _dioClient.database;
    var value = module.toJson(data);

    // print("objectData: ${_dioClient.getMusicPlayerTableName} , ${value}");

    var result = await db.insert(
      _dioClient.getMusicPlayListTable.toString(),
      value,
    );
    return result;
  }

  Future<AllCategoryPlayList> getCategoryPlayList() async {
    try {
      await _dioClient.initializeDatabase();
      final res = await _dioClient.getCategoryPlayListMapList();

      return AllCategoryPlayList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> insertCategoryPlayList(CategoryPlayListModule data) async {
    Database db = await _dioClient.database;
    var value = module2.toJson(data);

    var result = await db.insert(
      _dioClient.getCategoryPlayListTable.toString(),
      value,
    );
    return result;
  }
}
