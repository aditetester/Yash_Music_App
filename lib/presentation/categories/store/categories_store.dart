import 'package:boilerplate_new_version/core/stores/error/error_store.dart';

import 'package:boilerplate_new_version/domain/entity/post/category_list.dart';
import 'package:boilerplate_new_version/domain/usecase/post/get_post_usecase.dart';
import 'package:boilerplate_new_version/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'categories_store.g.dart';

class CategoriesStore = _CategoriesStore with _$CategoriesStore;

abstract class _CategoriesStore with Store {
 
  // use cases:-----------------------------------------------------------------
  final GetPostUseCase _getPostUseCase;

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;

  // constructor:---------------------------------------------------------------
  _CategoriesStore(this._getPostUseCase, this.errorStore);

  // store variables:-----------------------------------------------------------
  static ObservableFuture<AllCategoryList?> emptyPostResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<AllCategoryList?> fetchPostsFuture =
      ObservableFuture<AllCategoryList?>(emptyPostResponse);

  @observable
  List<dynamic>? CategoryList;

  @observable
  bool success = false;

  List<dynamic>? get getCategories => CategoryList;
  // actions:-------------------------------------------------------------------
  @action
  List<dynamic>? fetchCategories() {
    final future = _getPostUseCase.call(params: null);
    fetchPostsFuture = ObservableFuture(future);
      
    future.then((postList) {
      this.CategoryList = postList.posts;
      return this.CategoryList;
    }).catchError((error) {
      errorStore.errorMessage = DioExceptionUtil.handleError(error);

    });
   return null;
   
  }
}















// class CategoriesPage {
//   final Dio _dio = Dio();
  
//   Future<List<dynamic>> fetchCategories() async {

//     try {
//       // Replace this with your actual API endpoint
//       final response = ;

//       if (response.statusCode == 200) {
//         return response.data['categories']; // Assuming the key is 'categories'
//       } else {
//         throw Exception("Failed to load categories");
//       }
//     } catch (e) {
//       throw Exception("Error fetching categories: $e");
//     }
//   }

// }

