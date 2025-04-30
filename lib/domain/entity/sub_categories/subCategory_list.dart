
import 'package:boilerplate_new_version/domain/entity/sub_categories/subCategory.dart';

class AllSubCategoryList {
  final List<SubCategoryModule>? subCategorytData;

  AllSubCategoryList({this.subCategorytData});

  factory AllSubCategoryList.fromJson(List<dynamic> json) {
    
    List<SubCategoryModule> subCategorytData = <SubCategoryModule>[];
    
     // Parse JSON string into a List of Map
    subCategorytData =  json.map((categ) => SubCategoryModule.fromMap(categ)).toList();
  
    return AllSubCategoryList(subCategorytData: subCategorytData);
  }
}
