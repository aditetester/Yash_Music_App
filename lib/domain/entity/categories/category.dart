import 'package:boilerplate_new_version/core/data/network/constants/network_constants.dart';

class CategoryModule {
  String? id;
  String? name;
  String? image;

  CategoryModule({this.id, this.name, this.image});

  factory CategoryModule.fromMap(Map<String, dynamic> json) => CategoryModule(
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