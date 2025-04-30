import 'package:boilerplate_new_version/domain/entity/category_play_list/category.dart';

class AllCategoryPlayList {
  final List<CategoryPlayListModule>? categorytdata;

  AllCategoryPlayList({this.categorytdata});

  factory AllCategoryPlayList.fromJson(List<dynamic> json) {
    
    List<CategoryPlayListModule> categorytdata = <CategoryPlayListModule>[];
    
     // Parse JSON string into a List of Map
    categorytdata =  json.map((categ) => CategoryPlayListModule.fromMap(categ)).toList();
  
    return AllCategoryPlayList(categorytdata: categorytdata);
  }
}
