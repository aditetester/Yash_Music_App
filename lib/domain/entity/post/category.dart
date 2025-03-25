import 'package:boilerplate_new_version/core/data/network/constants/network_constants.dart';

class Category {
  String? id;
  String? name;
  String? image;

  Category({this.id, this.name, this.image});

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json['_id'],
    image: "${NetworkConstants.baseUrl}${json['image']['file']}",
    name: json['category_name'],
  );
  
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image': image,
      'category_name': name,
  };
 }
}