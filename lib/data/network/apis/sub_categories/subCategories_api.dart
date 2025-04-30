
import 'dart:async';
import 'package:boilerplate_new_version/core/data/network/constants/network_constants.dart';
import 'package:boilerplate_new_version/domain/entity/sub_categories/subCategory_list.dart';
import '../../../../core/data/network/dio/dio_client.dart';

class SubCategoriesApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  SubCategoriesApi(this._dioClient);

  /// Returns list of post in response
  Future<AllSubCategoryList> getSubCategories() async {
    try {
      final res = await _dioClient.dio.get(NetworkConstants.subCategories);
  
      return AllSubCategoryList.fromJson(res.data['subCategories']);

    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}

