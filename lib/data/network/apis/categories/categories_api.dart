import 'dart:async';
import 'package:boilerplate_new_version/core/data/network/constants/network_constants.dart';
import 'package:boilerplate_new_version/domain/entity/categories/category_list.dart';
import '../../../../core/data/network/dio/dio_client.dart';

class CategoriesApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  CategoriesApi(this._dioClient);

  /// Returns list of post in response
  Future<AllCategoryList> getCategories() async {
    try {
      final res = await _dioClient.dio.get(NetworkConstants.categories);
  
      return AllCategoryList.fromJson(res.data['categories']);

    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
