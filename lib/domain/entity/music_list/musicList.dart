import 'package:boilerplate_new_version/core/data/network/constants/network_constants.dart';

class MusicListModule {
  String? id;
  String? title;
  String? subtitle;
  String? audio;
  String? image;
  String? subCategoryId;
  String? subCategoryName;
  String? lyrics;
  MusicListModule({this.id, this.title, this.image, this.subCategoryId, this.subtitle, this.audio, this.subCategoryName, this.lyrics});

  factory MusicListModule.fromMap(Map<String, dynamic> json) => MusicListModule(
    id: json['_id'],
    image: "${NetworkConstants.baseUrl}${json['image']['file']}",
    title: json['title'],
    subtitle: json['title'], //json['audio']['fileName'],
    audio: "${NetworkConstants.baseUrl}${json['audio']['file']}",
    subCategoryId: json['subcategory']['_id'],
    subCategoryName: json['subcategory']['subcategory_name'],
    lyrics :  "${NetworkConstants.baseUrl}${json['lyrics']['file']}",
  
  );
  
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'image': image,
      'title': title,
      'subtitle': subtitle,
      'audio': audio,
      'subcategory_id': subCategoryId,
      'subCategoryName': subCategoryName,
      'lyrics' : lyrics,
  };
 }
}