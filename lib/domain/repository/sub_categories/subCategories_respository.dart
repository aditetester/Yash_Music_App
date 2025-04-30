import 'package:boilerplate_new_version/domain/entity/sub_categories/subCategory_list.dart';

abstract class SubCategoriesRepository {

  Future<AllSubCategoryList> getSubCategoryList();
  
}
