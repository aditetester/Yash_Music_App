import 'package:boilerplate_new_version/presentation/music/music_list.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/musicPlayer_screen.dart';
import 'package:boilerplate_new_version/presentation/subCategories/sub_category_list.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate_new_version/presentation/categories/category_list.dart';
import '../../presentation/home/home.dart';

class Routes {
  Routes._();

  //static variables
  static const String home = '/home';
  static const String categoryList = '/categroiesList';
  static const String subCategoryList = '/subCategroiesList';
  static const String musicList = '/musciList';
  static const String musicPlayer = '/musciPlayer';
  
  

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomeScreen(),
    categoryList: (BuildContext context) => CategoryList(),
    subCategoryList: (BuildContext context) => SubCategoryList(),
    musicList: (BuildContext context) => MusicList(),
    musicPlayer : (BuildContext context) => MusicPlayerScreen(),
    
  };
}
