import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/presentation/ads/ads_screen.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/widgets/app_drawer.dart';
import 'package:boilerplate_new_version/presentation/home/widgets/category_view.dart';
import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final MusicControllerStore _musicControllerStore =
      getIt<MusicControllerStore>();
  TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;
  List<String> _recentlyPlayedSongs = [
    "Song A",
    "Song B",
    "Song C",
    "Song D",
    "Song E",
  ];
  List<String> _filteredSongs = [];

  @override
  void initState() {
    super.initState();
    _filteredSongs = _recentlyPlayedSongs;
  }

  void _filterSongs(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredSongs = _recentlyPlayedSongs;
      } else {
        _filteredSongs =
            _recentlyPlayedSongs
                .where(
                  (song) => song.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      drawer: AppDrawer(),
      drawerScrimColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
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

      bottomNavigationBar: IntrinsicHeight(
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Ensure the column takes only required height
          children: [
            BottomMusicPlayerBar(musicControllerStore: _musicControllerStore),
            AdsScreen(),
          ],
        ),
      ),
    );
  }

  // AppBar methods
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title:
          _isSearching
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
        if (!_isSearching)
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = true;
              });
            },
          )
        else
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() {
                _isSearching = false;
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
