
import 'package:boilerplate_new_version/data/network/apis/posts/post_api.dart';
import 'package:boilerplate_new_version/domain/repository/categories/Categories_repository.dart';

class CategoriesRepositoryImp extends CategoriesRepository {

  // api objects
  final PostApi _postApi;

  // constructor
  CategoriesRepositoryImp(this._postApi);

  @override
  Future<Map<String,dynamic>> getAllCategories() async {
    return await _postApi.getCategories();
  }
}
