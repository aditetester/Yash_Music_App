import 'dart:async';
import 'package:boilerplate_new_version/data/network/constants/music_api.dart';

import '../../../../core/data/network/dio/dio_client.dart';


class PostApi {
  // dio instance
  final DioClient _dioClient;

 

  // injecting dio instance
  PostApi(this._dioClient);

  /// Returns list of post in response
  Future<Map<String,dynamic>> getCategories() async {
    try {
      final res = await _dioClient.dio.get(MusicApis.categories);

      return res.data;
      

    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// sample api call with default rest client
//   Future<PostList> getPosts() async {
//     try {
//       final res = await _restClient.get(Endpoints.getPosts);
//       return PostList.fromJson(res.data);
//     } catch (e) {
//       print(e.toString());
//       throw e;
//     }
//   }
}
