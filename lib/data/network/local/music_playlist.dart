import 'dart:async';
import 'package:boilerplate_new_version/core/data/Local/dataBase_Helper.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';
import 'package:sqflite/sqflite.dart';

class LocalMusicPlayList {
  // dio instance
  final MusicPlayerDBHelper _dioClient;
  MusicListModule module = MusicListModule();

  // injecting dio instance
  LocalMusicPlayList(this._dioClient);

  /// Returns list of post in response
  Future<AllMusicList> getMusicPlayList() async {
    try {
      await _dioClient.initializeDatabase();
      final res = await _dioClient.getPlayListMapList();

      return AllMusicList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> insertMusicPlayList(MusicListModule data) async {

    Database db = await _dioClient.database;
    var value =  module.toJson(data);
    
    // print("objectData: ${_dioClient.getMusicPlayerTableName} , ${value}");
   
    var result = await db.insert(_dioClient.getMusicPlayListTable.toString(), value);
    return result;
  }
}
