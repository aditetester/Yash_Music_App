
import 'package:boilerplate_new_version/core/domain/usecase/use_case.dart';
import 'package:boilerplate_new_version/domain/entity/categories/category_list.dart';
import 'package:boilerplate_new_version/domain/repository/categories/Categories_repository.dart';

class GetCategoryUseCase extends UseCase<AllCategoryList, void> {

  final CategoriesRepository  _postRepository;

  GetCategoryUseCase(this._postRepository);

  @override
  Future<AllCategoryList> call({required params}) {
    return _postRepository.getCategoryList();
  }
}