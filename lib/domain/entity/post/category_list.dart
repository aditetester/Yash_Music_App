class AllCategoryList {
  final List<dynamic>? posts;

  AllCategoryList({this.posts});

  factory AllCategoryList.fromJson(Map<String, dynamic> json) {
    
    List<dynamic> posts = <dynamic>[];
    posts = json['categories'];
        // json2
        //     .map(
        //       (ele) => Category(
        //         id: ele['_id'],
        //         name: ele['category_name'],
        //         image: "http://192.168.1.143:3000/${ele['image']['file']}",
        //       ),
        //     )
        //     .toList();
   
    return AllCategoryList(posts: posts);
  }
}
