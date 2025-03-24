import 'package:boilerplate_new_version/domain/entity/post/category.dart';

class AllCategoryList {
  final Map<String,dynamic>? posts;

  AllCategoryList({
    this.posts,
  });

  factory AllCategoryList.fromJson(Map<String,dynamic> json) {
    List<Category> posts = <Category>[];
    posts = json['categories'].map((post) => Category.fromMap(post)).toList();

    return AllCategoryList(
      posts: posts,
    );
  }
}
