import 'package:boilerplate_new_version/domain/entity/subCategories/subCategory_list.dart';

abstract class SubCategoriesRepository {

  Future<AllSubCategoryList> getSubCategoryList();
  
}
