import 'package:boilerplate_new_version/data/repository/subcategories/subCategories_respository_imp.dart';
import 'package:boilerplate_new_version/domain/entity/post/category.dart';
import 'package:mobx/mobx.dart';

part 'sub_categories_store.g.dart';

class SubCategoriesStore = _SubCategoriesStore with _$SubCategoriesStore;

abstract class _SubCategoriesStore with Store {
  SubCategoriesRepositoryImp? _repository;


  // constructor:---------------------------------------------------------------
  _SubCategoriesStore(SubCategoriesRepositoryImp repository) : this._repository = repository;

  @observable
  Map<String, dynamic>? CategoryList;

  @observable
  bool success = false;

  // actions:-------------------------------------------------------------------
  @action
  Future<List<dynamic>> fetchSubCategories(var categoryId) async {
   CategoryList = await _repository!.getSubCategoryList();

   final Subcategory = CategoryList!['subCategories']; 
   print(Subcategory);
   return CategoryList!['subCategories'];
   
  }
}