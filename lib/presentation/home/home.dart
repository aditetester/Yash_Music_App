import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/presentation/ads/ads_screen.dart';
import 'package:boilerplate_new_version/presentation/home/store/homeController/home_store.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:boilerplate_new_version/widgets/app_drawer.dart';
import 'package:boilerplate_new_version/presentation/home/widgets/category_view.dart';
import 'package:boilerplate_new_version/widgets/bottom_downloadedMusicPlayer_bar.dart';
import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeControllerStore _homeControllerStore = getIt<HomeControllerStore>();
  final MusicControllerStore _musicControllerStore =
      getIt<MusicControllerStore>();
  TextEditingController _searchController = TextEditingController();

  List<String> _filteredSongs = [];
  @override
  void initState() {
    super.initState();
    _filteredSongs = _homeControllerStore.recentlyPlayedSongs;
  }

  void _filterSongs(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSongs = _homeControllerStore.recentlyPlayedSongs;
      } else {
        _filteredSongs =
            _homeControllerStore.recentlyPlayedSongs
                .where(
                  (song) => song.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      }
    });
  }
 Future<void> _refresh() async {
    // Call your data fetching logic here
    Navigator.of(context).pushReplacementNamed(Routes.home);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: _buildAppBar(),
        drawer: AppDrawer(),
        drawerScrimColor: Theme.of(context).scaffoldBackgroundColor,
        body: RefreshIndicator(
      onRefresh: _refresh,
      child:SingleChildScrollView(
         physics: AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Categories Section
                CategoryViewScreen(),
                const SizedBox(height: 20),
                // Recently Played Section
                _builderRecentPlay(context),
              ],
            ),
          ),
        ),
       ),
        bottomNavigationBar: Observer(
          builder: (context) => IntrinsicHeight(
            child: Column(
              mainAxisSize:
                  MainAxisSize.min, // Ensure the column takes only required height
              children: [
                _musicControllerStore.isDownloadedPlaying
                    ? BottomDownloadedMusicPlayerBar(
                      musicControllerStore: _musicControllerStore,
                    )
                    : BottomMusicPlayerBar(
                      musicControllerStore: _musicControllerStore,
                    ),
                // AdsScreen(),
              ],
            ),
          ),
        ),
     
    );
  }

  // AppBar methods
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title:
          _homeControllerStore.isSearching
              ? TextField(
                controller: _searchController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white70),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: _filterSongs,
              )
              : Text("Music App"),
      actions: [
        if (!_homeControllerStore.isSearching)
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                _homeControllerStore.changeIsSearch(true);
              });
            },
          )
        else
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                _homeControllerStore.changeIsSearch(false);
                _searchController.clear();
                _filterSongs('');
              });
            },
          ),
      ],
    );
  }

  // Body methods
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
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _filteredSongs.length,
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
                      const SizedBox(height: 8),
                      Text(
                        _filteredSongs[index],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 4),
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
