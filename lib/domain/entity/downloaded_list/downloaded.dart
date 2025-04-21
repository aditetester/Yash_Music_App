import 'package:boilerplate_new_version/core/data/network/constants/network_constants.dart';


class DownloadedListModule {
  String? id;
  String? title;
  String? subtitle;
  String? audio;
  String? image;
  String? subCategoryId;
  String? subCategoryName;
  String? lyrics;
  DownloadedListModule({this.id, this.title, this.image, this.subCategoryId, this.subtitle, this.audio, this.subCategoryName, this.lyrics});

  factory DownloadedListModule.fromMap(Map<String, dynamic> json) => DownloadedListModule(
    id: json['id'].toString(),
    title: json['title'].toString(),
    subtitle: json['subTitle'].toString(),
    audio: json['audio'].toString(),
    image: json['image'].toString(),
    subCategoryId: json['subCategoryId'].toString(),
    subCategoryName: json['subCategoryName'].toString(),
    lyrics : json['lyrics'].toString(),
  
  );
  
  Map<String, dynamic> toJson(DownloadedListModule data) {
    
    return {
      'title': data.title.toString(),
      'subTitle': data.subtitle.toString(),
      'audio': data.audio.toString(),
      'image': data.image.toString(),
      'subCategoryId': data.subCategoryId.toString(),
      'subCategoryName': data.subCategoryName.toString(),
      'lyrics' : data.lyrics.toString(),
  };
 }
}