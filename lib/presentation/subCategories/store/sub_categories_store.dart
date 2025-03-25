
import 'package:boilerplate_new_version/core/stores/error/error_store.dart';
import 'package:boilerplate_new_version/domain/entity/subCategories/subCategory.dart';
import 'package:boilerplate_new_version/domain/entity/subCategories/subCategory_list.dart';
import 'package:boilerplate_new_version/domain/usecase/sub_categories/get_subcategories_usecase.dart';
import 'package:boilerplate_new_version/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'sub_categories_store.g.dart';

class SubCategoriesStore = _SubCategoriesStore with _$SubCategoriesStore;

abstract class _SubCategoriesStore with Store {
 
  // use cases:-----------------------------------------------------------------
  final GetSubCategoryUseCase _getSubCategoryUseCase;

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;

  // constructor:---------------------------------------------------------------
  _SubCategoriesStore(this._getSubCategoryUseCase, this.errorStore);

  // store variables:-----------------------------------------------------------
  static ObservableFuture<AllSubCategoryList?> emptyCategoryResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<AllSubCategoryList?> fetchPostsFuture =
      ObservableFuture<AllSubCategoryList?>(emptyCategoryResponse);

  @observable
  List<SubCategoryModule>? subCategoryList;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> fetchCategories() async {
    final future = _getSubCategoryUseCase.call(params: null);
    fetchPostsFuture = ObservableFuture(future);
      
    await future.then((SubpostList) {
      subCategoryList = SubpostList.posts;
    }).catchError((error) {
      errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }
}

// import 'package:boilerplate_new_version/data/repository/subcategories/subCategories_respository_imp.dart';
// import 'package:mobx/mobx.dart';

// part 'sub_categories_store.g.dart';

// class SubCategoriesStore = _SubCategoriesStore with _$SubCategoriesStore;

// abstract class _SubCategoriesStore with Store {
//   SubCategoriesRepositoryImp? _repository;


//   // constructor:---------------------------------------------------------------
//   _SubCategoriesStore(SubCategoriesRepositoryImp repository) : this._repository = repository;

//   @observable
//   Map<String, dynamic>? CategoryList;

//   @observable
//   bool success = false;

//   // actions:-------------------------------------------------------------------
//   @action
//   Future<List<dynamic>> fetchSubCategories(var categoryId) async {
//   //  CategoryList = await _repository!.getSubCategoryList();

//    final Subcategory = CategoryList!['subCategories']; 
//    print(Subcategory);
//    return CategoryList!['subCategories'];
   
//   }
// }
