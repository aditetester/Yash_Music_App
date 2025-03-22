import 'package:boilerplate_new_version/presentation/dashboard/main_dashboard.dart';

import '../../presentation/home/home.dart';
import '../../presentation/login/login.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String login = '/login';
  static const String home = '/home';
  static const String mainDashboard = '/main_dashboard';
  static final routes = <String, WidgetBuilder>{
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomeScreen(),
    mainDashboard: (BuildContext context) =>  MainDashboard(),
  };
}
