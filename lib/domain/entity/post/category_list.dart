import 'package:boilerplate_new_version/domain/entity/post/category.dart';

class AllCategoryList {
  final List<Category>? posts;

  AllCategoryList({this.posts});

  factory AllCategoryList.fromJson(List<dynamic> json) {
    
    List<Category> posts = <Category>[];
    
     // Parse JSON string into a List of Map
    posts =  json.map((categ) => Category.fromMap(categ)).toList();
  
    return AllCategoryList(posts: posts);
  }
}
