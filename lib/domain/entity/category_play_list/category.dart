class CategoryPlayListModule {
  String? id;
  String? name;
  String? totalSongs;

  CategoryPlayListModule({this.id, this.name, this.totalSongs});

  factory CategoryPlayListModule.fromMap(Map<String, dynamic> json) =>
      CategoryPlayListModule(
        id: json['categoryId'].toString(),
        name: json['categoryName'].toString(),
        totalSongs: json['totalSongs'].toString(),
      );

  Map<String, dynamic> toJson(CategoryPlayListModule data) {
    return {
     
      'categoryName': data.name.toString(),
      'totalSongs': data.totalSongs.toString(),
    };
  }
}
