
import 'package:boilerplate_new_version/domain/entity/post/category_list.dart';

abstract class CategoriesRepository {

  Future<AllCategoryList> getCategoryList();
  
}
