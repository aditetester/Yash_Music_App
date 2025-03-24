
import 'package:boilerplate_new_version/domain/di/module/usecase_module.dart';
import 'package:boilerplate_new_version/domain/entity/post/category_list.dart';
import 'package:boilerplate_new_version/domain/repository/categories/Categories_repository.dart';

class GetPostUseCase extends UseCaseModule<AllCategoryList, void> {

  final CategoriesRepository  _postRepository;

  GetPostUseCase(this._postRepository);

  @override
  Future<> call({required params}) {
    return _postRepository.getCategoryList();
  }
}