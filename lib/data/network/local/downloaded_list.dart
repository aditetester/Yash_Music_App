import 'package:boilerplate_new_version/core/data/local/database_helper.dart';
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded.dart';
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded_list.dart';
import 'package:sqflite/sqflite.dart';

class LocalDownloadedMusicList {
  // dio instance
  final MusicPlayerDBHelper _dioClient;
  DownloadedListModule module = DownloadedListModule();

  // injecting dio instance
  LocalDownloadedMusicList(this._dioClient){
   _dioClient.initializeDatabase();
  }

  /// Returns list of post in response
  Future<AllDownloadedList> getMusicList() async {
    try {
      await _dioClient.initializeDatabase();
      final res = await _dioClient.getMusicMapList();
      print("objectdd: $res");
      return AllDownloadedList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<int> insertDownloadedMusic(DownloadedListModule data) async {

    Database db = await _dioClient.database;
    var value =  module.toJson(data);
    
    // print("objectData: ${_dioClient.getMusicPlayerTableName} , ${value}");
   
    var result = await db.insert(_dioClient.getMusicPlayerTableName.toString(), value);
    return result;
  }
}
