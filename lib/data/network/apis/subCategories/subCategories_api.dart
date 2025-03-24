import 'dart:async';

import 'package:boilerplate_new_version/core/data/network/constants/network_constants.dart';

import '../../../../core/data/network/dio/dio_client.dart';


class SubCategoriesApi {
  // dio instance
  final DioClient _dioClient;

 

  // injecting dio instance
  SubCategoriesApi(this._dioClient);

  /// Returns list of post in response
  Future<Map<String,dynamic>> getSubCategories() async {
    try {
      final res = await _dioClient.dio.get(NetworkConstants.subCategories);

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
