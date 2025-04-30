
import 'package:boilerplate_new_version/core/stores/error/error_store.dart';
import 'package:boilerplate_new_version/domain/entity/sub_categories/subCategory.dart';
import 'package:boilerplate_new_version/domain/entity/sub_categories/subCategory_list.dart';
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
  Future<void> fetchSubCategories() async {
    final future = _getSubCategoryUseCase.call(params: null);
    fetchPostsFuture = ObservableFuture(future);
      
    await future.then((SubpostList) {
      subCategoryList = SubpostList.subCategorytData;
    }).catchError((error) {
      errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }

  @action
  Future<void> SelectSubCategories(String categoryId) async {
    subCategoryList = subCategoryList!.where((element) => element.categoryId == categoryId).toList();
  }

}
