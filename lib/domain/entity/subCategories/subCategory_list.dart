
import 'package:boilerplate_new_version/domain/entity/subCategories/subCategory.dart';

class AllSubCategoryList {
  final List<SubCategoryModule>? posts;

  AllSubCategoryList({this.posts});

  factory AllSubCategoryList.fromJson(List<dynamic> json) {
    
    List<SubCategoryModule> posts = <SubCategoryModule>[];
    
     // Parse JSON string into a List of Map
    posts =  json.map((categ) => SubCategoryModule.fromMap(categ)).toList();
  
    return AllSubCategoryList(posts: posts);
  }
}
