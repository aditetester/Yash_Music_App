import 'package:boilerplate_new_version/core/data/network/constants/network_constants.dart';

class MusicListModule {
  String? recentId;
  String? id;
  String? title;
  String? subtitle;
  String? audio;
  String? image;
  String? subCategoryId;
  String? subCategoryName;
  String? lyrics;
  MusicListModule(
    {
    this.recentId,
    this.id,
    this.title,
    this.image,
    this.subCategoryId,
    this.subtitle,
    this.audio,
    this.subCategoryName,
    this.lyrics,
  });

  factory MusicListModule.fromMap(Map<String, dynamic> json) => MusicListModule(
    id: json['_id'],
    image: "${NetworkConstants.baseUrl}${json['image']['file']}",
    title: json['title'],
    subtitle: json['title'], //json['audio']['fileName'],
    audio: "${NetworkConstants.baseUrl}${json['audio']['file']}",
    subCategoryId: json['subcategory']['_id'],
    subCategoryName: json['subcategory']['subcategory_name'],
    lyrics: "${NetworkConstants.baseUrl}${json['lyrics']['file']}",
  );

  factory MusicListModule.fromMap2(Map<String, dynamic> json) =>
      MusicListModule(
        recentId: json['recentId'].toString(),
        id: json['id'].toString(),
        title: json['title'].toString(),
        subtitle: json['subTitle'].toString(),
        audio: json['audio'].toString(),
        image: json['image'].toString(),
        subCategoryId: json['subCategoryId'].toString(),
        subCategoryName: json['subCategoryName'].toString(),
        lyrics: json['lyrics'].toString(),
      );

  factory MusicListModule.fromMap3(Map<String, dynamic> json) =>
      MusicListModule(
        recentId: json['localId'].toString(),
        id: json['id'].toString(),
        title: json['title'].toString(),
        subtitle: json['subTitle'].toString(),
        audio: json['audio'].toString(),
        image: json['image'].toString(),
        subCategoryId: json['subCategoryId'].toString(),
        subCategoryName: json['subCategoryName'].toString(),
        lyrics: json['lyrics'].toString(),
      );

  Map<String, dynamic> toJson(MusicListModule data) {
    return {
      'id': data.id.toString(),
      'title': data.title.toString(),
      'subtitle': data.subtitle.toString(),
      'audio': data.audio.toString(),
      'image': data.image.toString(),
      'subCategoryId': data.subCategoryId.toString(),
      'subCategoryName': data.subCategoryName.toString(),
      'lyrics': data.lyrics.toString(),
    };
  }
}
