
import 'package:boilerplate_new_version/data/network/apis/categories/categories_api.dart';
import 'package:boilerplate_new_version/domain/entity/post/category_list.dart';
import 'package:boilerplate_new_version/domain/repository/categories/Categories_repository.dart';

class CategoriesRepositoryImp extends CategoriesRepository {

  // api objects
  final CategoriesApi _CategoriesApi;

  // constructor
  CategoriesRepositoryImp(this._CategoriesApi);

  @override
  Future<AllCategoryList> getCategoryList() async {
    return await _CategoriesApi.getCategories();
  }
}
