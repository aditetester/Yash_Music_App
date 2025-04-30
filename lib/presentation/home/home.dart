import 'dart:async';
import 'package:boilerplate_new_version/constants/app_theme.dart';
import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/presentation/downloaded_music_list/store/download_list_store.dart';
import 'package:boilerplate_new_version/presentation/home/store/homeController/home_store.dart';
import 'package:boilerplate_new_version/presentation/home/widgets/recent_play_view.dart';
import 'package:boilerplate_new_version/presentation/home/widgets/top_playlist_view.dart';
import 'package:boilerplate_new_version/presentation/music_player/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/presentation/recent_play_list/store/recent_music_list_store.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:boilerplate_new_version/widgets/app_drawer.dart';
import 'package:boilerplate_new_version/presentation/home/widgets/category_view.dart';
import 'package:boilerplate_new_version/widgets/bottom_downloadedMusicPlayer_bar.dart';
import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeControllerStore _homeControllerStore = getIt<HomeControllerStore>();
  final MusicControllerStore _musicControllerStore =
      getIt<MusicControllerStore>();

  final RecentMusicListStore _recentPlayListStore =
      getIt<RecentMusicListStore>();
  final DownloadListStore _downloadListStore = getIt<DownloadListStore>();

  List<String> _filteredSongs = [];
  List<MusicListModule>? _recentPlay = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _filteredSongs = _homeControllerStore.recentlyPlayedSongs;
    _recentPlayListStore.fetchRecentMusicList();
    _downloadListStore.fetchDownloadedMusicList();

    // Simulate loading for 3 seconds
    Timer(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> _refresh() async {
    Navigator.of(context).pushReplacementNamed(Routes.home);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        drawer: AppDrawer(),
        drawerScrimColor: Colors.black26,
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xC7DFDDEA),
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 8.0,
                        top: 15,
                        right: 20,
                      ),
                      child: Column(
                        children: [
                          _builderTopArea(context),
                          SizedBox(height: 15),
                          CategoryViewScreen(),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                    _builderRecentPlay(context),
                    SizedBox(height: 15),
                    _builderTopPlay(context),
                    SizedBox(height: 15),
                    _builderPopularArtist(context),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Observer(
          builder:
              (context) => IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _musicControllerStore.isDownloadedPlaying
                        ? BottomDownloadedMusicPlayerBar(
                          musicControllerStore: _musicControllerStore,
                        )
                        : BottomMusicPlayerBar(
                          musicControllerStore: _musicControllerStore,
                        ),
                  ],
                ),
              ),
        ),
      ),
    );
  }

  Widget _builderTopArea(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  Scaffold.of(context).openDrawer();
                },
                icon: SvgPicture.asset(
                  'assets/svg/drawer_icon.svg',
                  height: 4.h,
                  width: 4.w,
                ),
              );
            },
          ),
          SizedBox(width: 5),
          Expanded(
            child: Container(
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8), // More curved borders
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black12,
                //     blurRadius: 4,
                //     offset: Offset(0, 2),
                //   ),
                // ],
              ),
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.searchMusicScreen);
                },
                child: TextFormField(
                  enabled: false,
                  cursorColor: Colors.black,
                  cursorHeight: 20,
                  style: AppThemeData.textThemeMedium,
                  onChanged: (value) {},
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 0,
                      vertical: 9,
                    ),
                    hintText: "Search songs, playlists and artists",
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 177, 177, 177),
                      fontSize: 12,
                    ),
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(Icons.search, color: Colors.black, size: 20),
                    ),
                    prefixIconConstraints: const BoxConstraints(
                      minHeight: 20,
                      minWidth: 20,
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: IconButton(
                        constraints: BoxConstraints(minHeight: 0, minWidth: 0),
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          Icons.mic_none_outlined,
                          color: Colors.black,
                          size: 20,
                        ),
                        onPressed: () {},
                      ),
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      minHeight: 20,
                      minWidth: 40,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _builderRecentPlay(BuildContext context) {
    return Observer(
      builder: (context) {
        _recentPlay = _recentPlayListStore.AllMusic;
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 15, right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Recently Played", style: AppThemeData.textThemeBold),
                  GestureDetector(
                    onTap:
                        () => Navigator.of(
                          context,
                        ).pushNamed(Routes.recentMusicPlayListScreen),
                    child: Text(
                      "See all",
                      style: AppThemeData.textThemeRegular,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 10),
              child:
                  (_isLoading || (_recentPlay?.isNotEmpty ?? false))
                      ? SizedBox(
                        height: 18.h, // Set the height only if there is content
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: _isLoading ? 5 : _recentPlay!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 38.w,
                              margin: EdgeInsets.only(right: 10),
                              child:
                                  _isLoading
                                      ? _shimmerBox(
                                        width: 38.w,
                                        height: 18.h,
                                        borderRadius: BorderRadius.circular(10),
                                      )
                                      : RecentPlayView(
                                        id: _recentPlay![index].id ?? "",
                                        title:
                                            _recentPlay![index].title ??
                                            "No Title",
                                        subTitle:
                                            _recentPlay![index].subtitle ?? "",
                                        image: _recentPlay![index].image ?? "",
                                      ),
                            );
                          },
                        ),
                      )
                      : Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                        child: Text(
                          "No Recent Play available",
                          style: AppThemeData.textThemeMedium,
                        ),
                      ),
            ),
          ],
        );
      },
    );
  }

  Widget _builderTopPlay(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15, right: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Top Playlists", style: AppThemeData.textThemeBold),
              Text("See all", style: AppThemeData.textThemeRegular),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 10),
          child: SizedBox(
            height: 16.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _isLoading ? 5 : _filteredSongs.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 35.w,
                  margin: EdgeInsets.only(right: 10),
                  child:
                      _isLoading
                          ? _shimmerBox(
                            width: 35.w,
                            height: 16.h,
                            borderRadius: BorderRadius.circular(12),
                          )
                          : TopPlaylistCard(
                            imageUrls: [
                              "assets/icon/icon.png",
                              "assets/images/demo_img.jpg",
                              "assets/images/demo_img.jpg",
                              "assets/icon/icon.png",
                            ],
                            songCount: 4,
                            onPlay: () {},
                          ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _builderPopularArtist(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 15, right: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Popular Artists", style: AppThemeData.textThemeBold),
              Text("See all", style: AppThemeData.textThemeRegular),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 18.0, top: 10),
          child: SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _isLoading ? 5 : _filteredSongs.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  margin: EdgeInsets.only(right: 12),
                  child:
                      _isLoading
                          ? Column(
                            children: [
                              _shimmerBox(
                                width: 90,
                                height: 90,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              SizedBox(height: 8),
                              _shimmerBox(width: 60, height: 10),
                            ],
                          )
                          : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.asset(
                                  "assets/images/demo_img.jpg",
                                  height: 90,
                                  width: 90,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "test1",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _shimmerBox({
    required double width,
    required double height,
    BorderRadius? borderRadius,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(8),
        ),
      ),
    );
  }
}




//old ui----------------------------------------------------------
// // RecentPlay
// Column(
//   crossAxisAlignment: CrossAxisAlignment.center,
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     Icon(
//       Icons.play_circle_fill,
//       size: 48,
//       color: Colors.white,
//     ),
//     const SizedBox(height: 8),
//     Text(
//       _filteredSongs[index],
//       style: TextStyle(
//         fontSize: 14,
//         color: Colors.white,
//         fontWeight: FontWeight.bold,
//       ),
//       textAlign: TextAlign.center,
//     ),
//     const SizedBox(height: 4),
//     Text(
//       "Artist",
//       style: TextStyle(fontSize: 12, color: Colors.grey[300]),
//       textAlign: TextAlign.center,
//     ),
//   ],
// ),


  // // AppBar methods
  // PreferredSizeWidget _buildAppBar() {
  //   return AppBar(
  //     title:
  //         _homeControllerStore.isSearching
  //             ? TextField(
  //               controller: _searchController,
  //               autofocus: true,
  //               decoration: InputDecoration(
  //                 hintText: 'Search...',
  //                 border: InputBorder.none,
  //                 hintStyle: TextStyle(color: Colors.white70),
  //               ),
  //               style: TextStyle(color: Colors.white),
  //               onChanged: _filterSongs,
  //             )
  //             : Text("Music App"),
  //     actions: [
  //       if (!_homeControllerStore.isSearching)
  //         IconButton(
  //           icon: Icon(Icons.search),
  //           onPressed: () {
  //             setState(() {
  //               _homeControllerStore.changeIsSearch(true);
  //             });
  //           },
  //         )
  //       else
  //         IconButton(
  //           icon: Icon(Icons.close),
  //           onPressed: () {
  //             setState(() {
  //               _homeControllerStore.changeIsSearch(false);
  //               _searchController.clear();
  //               _filterSongs('');
  //             });
  //           },
  //         ),
  //     ],
  //   );
  // }

