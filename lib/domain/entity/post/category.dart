class Category {
  int? userId;
  int? id;
  String? title;
  String? body;

  Category({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
  
}
