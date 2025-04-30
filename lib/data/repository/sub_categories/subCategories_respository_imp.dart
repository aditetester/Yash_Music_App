
import 'package:boilerplate_new_version/data/network/apis/sub_categories/subCategories_api.dart';
import 'package:boilerplate_new_version/domain/entity/sub_categories/subCategory_list.dart';
import 'package:boilerplate_new_version/domain/repository/sub_categories/subCategories_respository.dart';

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
