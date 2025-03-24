
import 'package:boilerplate_new_version/data/network/apis/subCategories/subCategories_api.dart';
import 'package:boilerplate_new_version/domain/repository/subCategories/subCategories_respository.dart';

class SubCategoriesRepositoryImp extends SubCategoriesRepository {

  // api objects
  final SubCategoriesApi _CategoriesApi;

  // constructor
  SubCategoriesRepositoryImp(this._CategoriesApi);

  @override
  Future<Map<String,dynamic>> getSubCategoryList() async {
    return await _CategoriesApi.getSubCategories();
  }
}
