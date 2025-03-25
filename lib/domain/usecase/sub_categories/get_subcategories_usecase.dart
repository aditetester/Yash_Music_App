
import 'package:boilerplate_new_version/core/domain/usecase/use_case.dart';
import 'package:boilerplate_new_version/domain/entity/subCategories/subCategory_list.dart';
import 'package:boilerplate_new_version/domain/repository/subCategories/subCategories_respository.dart';

class GetSubCategoryUseCase extends UseCase<AllSubCategoryList, void> {

  final SubCategoriesRepository _subCategoryRepository;

  GetSubCategoryUseCase(this._subCategoryRepository);

  @override
  Future<AllSubCategoryList> call({required params}) {
    return _subCategoryRepository.getSubCategoryList();
  }
}