
import 'package:boilerplate_new_version/data/network/apis/subCategories/subCategories_api.dart';
import 'package:boilerplate_new_version/domain/entity/subCategories/subCategory_list.dart';
import 'package:boilerplate_new_version/domain/repository/subCategories/subCategories_respository.dart';

class SubCategoriesRepositoryImp extends SubCategoriesRepository {

  // api objects
  final SubCategoriesApi _SubCategoriesApi;

  // constructor
  SubCategoriesRepositoryImp(this._SubCategoriesApi);

  @override
  Future<AllSubCategoryList> getSubCategoryList() async {
    return await _SubCategoriesApi.getSubCategories();
  }
}
