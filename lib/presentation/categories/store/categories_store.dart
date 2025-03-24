import 'package:boilerplate_new_version/data/repository/categories/categories_respository_imp.dart';
import 'package:mobx/mobx.dart';

part 'categories_store.g.dart';

class CategoriesStore = _CategoriesStore with _$CategoriesStore;

abstract class _CategoriesStore with Store {
  CategoriesRepositoryImp? _repository;


  // constructor:---------------------------------------------------------------
  _CategoriesStore(CategoriesRepositoryImp repository) : this._repository = repository;

  @observable
  Map<String, dynamic>? CategoryList;

  @observable
  bool success = false;

  // actions:-------------------------------------------------------------------
  @action
  Future<List<dynamic>> fetchCategories() async {
   
   CategoryList = await _repository!.getCategoryList();
   
   return CategoryList!['categories'];
   
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

