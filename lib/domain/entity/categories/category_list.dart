import 'package:boilerplate_new_version/domain/entity/categories/category.dart';

class AllCategoryList {
  final List<CategoryModule>? categorytdata;

  AllCategoryList({this.categorytdata});

  factory AllCategoryList.fromJson(List<dynamic> json) {
    
    List<CategoryModule> categorytdata = <CategoryModule>[];
    
     // Parse JSON string into a List of Map
    categorytdata =  json.map((categ) => CategoryModule.fromMap(categ)).toList();
  
    return AllCategoryList(categorytdata: categorytdata);
  }
}
