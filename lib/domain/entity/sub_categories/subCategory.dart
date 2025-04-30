import 'package:boilerplate_new_version/core/data/network/constants/network_constants.dart';

class SubCategoryModule {
  String? id;
  String? name;
  String? image;
  String? categoryId;

  SubCategoryModule({this.id, this.name, this.image, this.categoryId});

  factory SubCategoryModule.fromMap(Map<String, dynamic> json) => SubCategoryModule(
    id: json['_id'],
    image: "${NetworkConstants.baseUrl}${json['image']['file']}",
    name: json['subcategory_name'],
    categoryId: json['category']['_id'],
  );
  
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image': image,
      'subcategory_name': name,
      'category_id': categoryId,
  };
 }
}