import 'dart:async';
import 'package:boilerplate_new_version/core/data/Local/dataBase_Helper.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';
import 'package:sqflite/sqflite.dart';

class LocalRecentPlayList {
  // dio instance
  MusicPlayerDBHelper _dioClient;
  MusicListModule module = MusicListModule();
  

  // injecting dio instance
  LocalRecentPlayList(this._dioClient);

  /// Returns list of post in response
  Future<AllMusicList> getRecentPlayList() async {
    try {
      await _dioClient.initializeDatabase();
      final res = await _dioClient.getRecentPlayListMapList();

      return AllMusicList.fromJson2(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> insertRecentPlayList(MusicListModule data) async {

    Database db = await _dioClient.database;
    var value =  module.toJson(data);
    
    // print("objectData: ${_dioClient.getMusicPlayerTableName} , ${value}");
   
    var result = await db.insert(_dioClient.getRecentPlayListTable.toString(), value);
    
    return result;
  }
}
