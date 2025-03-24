import 'package:boilerplate_new_version/presentation/ads/ads_screen.dart';

import 'package:boilerplate_new_version/widgets/app_drawer.dart';
import 'package:boilerplate_new_version/presentation/home/widgets/category_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: AppDrawer(),
      drawerScrimColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Categories Section
                    CategoryViewScreen(),
                    SizedBox(height: 20),
                    // Recently Played Section
                    _builderRecentPlay(context),
                  ],
                ),
              ),
            ),
          ),
          AdsScreen(),
        ],
      ),
    );
  }

  // Appbar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(title: Text("Music App"), actions: _buildActions(context));
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[IconButton(onPressed: () {}, icon: Icon(Icons.search))];
  }

  // Body methods:-----------------------------------------------------------

  Widget _builderRecentPlay(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recently Played",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Handle "View All" tap
                },
                child: Text(
                  "View All",
                  style: TextStyle(fontSize: 14, color: Colors.blueAccent),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Example data count
              itemBuilder: (context, index) {
                return Container(
                  width: 120,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.teal[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.play_circle_fill,
                        size: 48,
                        color: Colors.white,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Song Name",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Artist",
                        style: TextStyle(fontSize: 12, color: Colors.grey[300]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
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

