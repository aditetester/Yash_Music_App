import 'package:boilerplate_new_version/core/stores/error/error_store.dart';
import 'package:boilerplate_new_version/domain/entity/post/category.dart';
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
  List<Category>? CategoryList;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> fetchCategories() async {
    final future = _getPostUseCase.call(params: null);
    fetchPostsFuture = ObservableFuture(future);
      
    await future.then((postList) {
      CategoryList = postList.posts;
    }).catchError((error) {
      errorStore.errorMessage = DioExceptionUtil.handleError(error);
    
    });
   
   
  }
}















// class CategoriesPage {
//   final Dio _dio = Dio();
  
//   Future<List<Category>> fetchCategories() async {

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

