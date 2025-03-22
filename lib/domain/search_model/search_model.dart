import 'package:flutter/cupertino.dart';

class SearchModel with ChangeNotifier{

  String item_id;
  String download_name;
  String item_name;
  String item_description;
  String item_file;
  String item_image;
  String video_url;
  String category_id;
  String category_name;
  String category_image;

  SearchModel({
      required this.item_id,
      required this.download_name,
      required this.item_name,
      required this.item_description,
      required this.item_file,
      required this.item_image,
      required this.video_url,
      required this.category_id,
      required this.category_name,
      required this.category_image});
}

/*
[{"item_id":"1",
"download_name":"test",
"item_name":"test",
"item_description":"ewrwerew",
"item_file":"https:\/\/www.youtube.com\/watch?v=zQnBQ4tB3ZA",
"item_image":"http:\/\/aditetechnologies.com\/VideoApp\/assets\/upload\/items\/item_img\/",
"video_url":"https:\/\/www.youtube.com\/watch?v=zQnBQ4tB3ZA","duration":"",
"category_id":"2",
"category_name":"rawania",
"category_image":"http:\/\/aditetechnologies.com\/VideoApp\/assets\/upload\/category\/Ben10_3.png"}]

 */
