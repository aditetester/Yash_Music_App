import 'package:boilerplate_new_version/core/data/network/constants/network_constants.dart';

class MusicListModule {
  String? id;
  String? title;
  String? subtitle;
  String? image;
  String? subCategoryId;

  MusicListModule({this.id, this.title, this.image, this.subCategoryId, this.subtitle,});

  factory MusicListModule.fromMap(Map<String, dynamic> json) => MusicListModule(
    id: json['_id'],
    image: "${NetworkConstants.baseUrl}${json['image']['file']}",
    title: json['title'],
    subtitle: json['title'], //json['audio']['fileName'],
    subCategoryId: json['subcategory']['_id'],

  );
  
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image': image,
      'title': title,
      'subtitle': subtitle,
      'subcategory_id': subCategoryId,
  };
 }
}