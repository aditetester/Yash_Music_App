import 'package:boilerplate_new_version/core/stores/error/error_store.dart';
import 'package:boilerplate_new_version/domain/entity/categories/category.dart';
import 'package:boilerplate_new_version/domain/entity/categories/category_list.dart';
import 'package:boilerplate_new_version/domain/usecase/categories/get_category_usecase.dart';
import 'package:boilerplate_new_version/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'categories_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
 
  // use cases:-----------------------------------------------------------------
  final GetCategoryUseCase _getCategoryUseCase;

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;

  // constructor:---------------------------------------------------------------
  _CategoryStore(this._getCategoryUseCase, this.errorStore);

  // store variables:-----------------------------------------------------------
  static ObservableFuture<AllCategoryList?> emptyCategoryResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<AllCategoryList?> fetchPostsFuture =
      ObservableFuture<AllCategoryList?>(emptyCategoryResponse);

  @observable
  List<CategoryModule>? CategoryList;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> fetchCategories() async {
    final future = _getCategoryUseCase.call(params: null);
    fetchPostsFuture = ObservableFuture(future);
      
    await future.then((categoryList) {
      CategoryList = categoryList.posts;
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

