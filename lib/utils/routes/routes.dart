import 'package:boilerplate_new_version/presentation/categories/all_categories.dart';
import 'package:flutter/material.dart';
import '../../presentation/home/home.dart';


class Routes {
  Routes._();

  //static variables
  static const String home = '/home';
  static const String allCategories = '/allCategroies';
  
  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomeScreen(),
   allCategories: (BuildContext context) => AllCategories(),
    
  };
}
