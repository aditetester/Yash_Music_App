import 'package:boilerplate_new_version/presentation/home/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import '../../utils/locale/app_localization.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //stores:---------------------------------------------------------------------
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: AppDrawer(),
      body: Container(),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(AppLocalizations.of(context).translate('home_bar_name')),
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[IconButton(onPressed: () {}, icon: Icon(Icons.search))];
  }


}


//   Widget _buildLogoutButton() {
//     return IconButton(
//       onPressed: () {
//         SharedPreferences.getInstance().then((preference) {
//           preference.setBool(Preferences.is_logged_in, false);
//           Navigator.of(context).pushReplacementNamed(Routes.login);
//         });
//       },
//       icon: Icon(Icons.power_settings_new),
//     );
//   }

