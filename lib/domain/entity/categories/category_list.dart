import 'package:boilerplate_new_version/domain/entity/categories/category.dart';

class AllCategoryList {
  final List<CategoryModule>? posts;

  AllCategoryList({this.posts});

  factory AllCategoryList.fromJson(List<dynamic> json) {
    
    List<CategoryModule> posts = <CategoryModule>[];
    
     // Parse JSON string into a List of Map
    posts =  json.map((categ) => CategoryModule.fromMap(categ)).toList();
  
    return AllCategoryList(posts: posts);
  }
}
