
import 'dart:async';
import '../../../../core/data/network/dio/dio_client.dart';

class LyricsApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  LyricsApi(this._dioClient);

   Future<String> getLyrics(String Url) async {
    try {
      final res = await _dioClient.dio.get(Url);
  
      return res.data;

    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}

