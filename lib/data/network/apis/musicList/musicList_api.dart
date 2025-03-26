
import 'dart:async';
import 'package:boilerplate_new_version/core/data/network/constants/network_constants.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';
import '../../../../core/data/network/dio/dio_client.dart';

class MusicListApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  MusicListApi(this._dioClient);

  /// Returns list of post in response
  Future<AllMusicList> getMusicList() async {
    try {
      final res = await _dioClient.dio.get(NetworkConstants.musicList);
  
      return AllMusicList.fromJson(res.data['audios']);

    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}

