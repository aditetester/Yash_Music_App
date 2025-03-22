import 'package:flutter/cupertino.dart';

class AppAboutModel with ChangeNotifier{
  String content_management_id;
  String about_us;
  String terms_conditions;

  AppAboutModel({required this.content_management_id, required this.about_us, required this.terms_conditions});
}