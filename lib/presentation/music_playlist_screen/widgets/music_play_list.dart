import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/presentation/downloaded_music_list/store/download_list_store.dart';
import 'package:boilerplate_new_version/presentation/music/store/music_list_store.dart';
import 'package:boilerplate_new_version/presentation/music/widgets/music_items.dart';
import 'package:boilerplate_new_version/presentation/music_player/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/presentation/music_playlist_screen/store/music_playlist_store.dart';
import 'package:boilerplate_new_version/presentation/recent_play_list/store/recent_music_list_store.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:boilerplate_new_version/widgets/bottom_downloadedMusicPlayer_bar.dart';
import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:sizer/sizer.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:async';

class MusicPlayListView extends StatefulWidget {
  const MusicPlayListView({super.key});

  @override
  State<MusicPlayListView> createState() => _MusicListViewState();
}

class _MusicListViewState extends State<MusicPlayListView> {
  final MusicPlayListStore _MusicListStore = getIt<MusicPlayListStore>();
  final MusicControllerStore _musicControllerStore =
      getIt<MusicControllerStore>();
  final RecentMusicListStore _recentPlayListStore =
      getIt<RecentMusicListStore>();
  final DownloadListStore _downloadListStore = getIt<DownloadListStore>();

  final TextEditingController _searchController = TextEditingController();

  List<MusicListModule>? allMusicList = [];
  List<MusicListModule> filteredMusicList = [];

  bool showShimmer = true;

  @override
  void initState() {
    super.initState();
    _MusicListStore.fetchMusicPlayList();
    _recentPlayListStore.fetchRecentMusicList();
    _downloadListStore.fetchDownloadedMusicList();
    _searchController.addListener(_filterMusicList);

    Timer(Duration(seconds: 2), () {
      setState(() {
        showShimmer = false;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterMusicList() {
    final query = _searchController.text.toLowerCase();
    if (allMusicList != null && allMusicList!.isNotEmpty) {
      setState(() {
        filteredMusicList =
            allMusicList!
                .where((music) => music.title!.toLowerCase().contains(query))
                .toList();
      });
    } else {
      setState(() {
        filteredMusicList = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> subcategory =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xC7DFDDEA),
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 15, right: 8.0),
              child: _builderTopArea(context, subcategory['name'].toString()),
            ),
            Expanded(
              child: _builderBodyArea(context, subcategory['id'].toString()),
            ),
          ],
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
    );
  }

  Widget _builderTopArea(BuildContext context, String heading) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Image.asset(
            'assets/images/drawer_back_icon.png',
            height: 7.5.h,
            width: 7.5.w,
          ),
        ),
        SizedBox(width: 5),
        Expanded(
          child: Container(
            height: 4.h,
            alignment: Alignment.centerLeft,
            child: Text(
              "$heading Songs",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _builderBodyArea(BuildContext context, String subCategoryId) {
    return Observer(
      builder: (_) {
        _MusicListStore.SelectedMusicList(subCategoryId);

        allMusicList = _MusicListStore.AllMusicPlayList;

        if (showShimmer) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 6,
            itemBuilder:
                (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 8.0,
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
          );
        }

        if (allMusicList == null || allMusicList!.isEmpty) {
          return Center(child: Text("No Music List available"));
        }

        filteredMusicList = allMusicList!;
        _musicControllerStore.AllMusic = allMusicList!;

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: filteredMusicList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _recentPlayListStore.insertRecentPlayList(
                  id: filteredMusicList[index].id.toString(),
                  title: filteredMusicList[index].title.toString(),
                  subTitle: filteredMusicList[index].subtitle.toString(),
                  audio: filteredMusicList[index].audio.toString(),
                  image: filteredMusicList[index].image.toString(),
                  subCategoryId: filteredMusicList[index].subCategoryId.toString(),
                  subCategoryName: filteredMusicList[index].subCategoryName.toString(),
                  lyrics: filteredMusicList[index].lyrics.toString(),
                );
                _musicControllerStore.playNext(
                  currentIndex: index,
                  nextplay: filteredMusicList[index],
                );
                Navigator.of(context).pushNamed(
                  Routes.musicPlayer,
                  arguments: filteredMusicList[index],
                );
              },
              child: MusicItems(
                totalDuration: "00:00",
                index: index,
                music: filteredMusicList[index],
              ),
            );
          },
        );
      },
    );
  }
}

// old UI---------------------------------------------------------
// import 'package:boilerplate_new_version/di/service_locator.dart';
// import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
// import 'package:boilerplate_new_version/presentation/downloadedMusicList/store/download_list_store.dart';
// import 'package:boilerplate_new_version/presentation/music/store/music_list_store.dart';
// import 'package:boilerplate_new_version/presentation/music/widgets/music_items.dart';
// import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
// import 'package:boilerplate_new_version/utils/routes/routes.dart';
// import 'package:boilerplate_new_version/widgets/bottom_downloadedMusicPlayer_bar.dart';
// import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:mobx/mobx.dart';

// class MusicPlayList extends StatefulWidget {
//   const MusicPlayList({super.key});

//   @override
//   State<MusicPlayList> createState() => _MusicListState();
// }

// class _MusicListState extends State<MusicPlayList> {
//   MusicListStore _MusicListStore = getIt<MusicListStore>();
//   final MusicControllerStore _musicControllerStore =
//       getIt<MusicControllerStore>();
//   final DownloadListStore _downloadListStore = getIt<DownloadListStore>();
//   TextEditingController _searchController = TextEditingController();
//   List<MusicListModule>? allMusicList = [];
//   List<MusicListModule> filteredMusicList = [];

//   @override
//   void initState() {
//     super.initState();
//     _MusicListStore.fetchMusicList();
//     _downloadListStore.fetchDownloadedMusicList();

//     _searchController.addListener(_filterMusicList);
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }

//   void _filterMusicList() {
//     final query = _searchController.text.toLowerCase();
//     if (allMusicList != null && allMusicList!.isNotEmpty) {
//       setState(() {
//         filteredMusicList =
//             allMusicList!.where((music) {
//               final title = music.title!.toLowerCase();
//               return title.contains(query);
//             }).toList();
//       });
//     } else {
//       // If the list is null or empty, ensure filteredMusicList is also empty
//       setState(() {
//         filteredMusicList = [];
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final  Map<String, dynamic> subcategory =
//         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
//     //  "6715f190725b819f0474bbd9";
//     return Scaffold(
//       appBar: AppBar(title: Text(subcategory['name']), centerTitle: true),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Column(
//           children: [
//             // Search Bar
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextField(
//                 controller: _searchController,
//                 style: const TextStyle(fontSize: 15),
//                 decoration: InputDecoration(
//                   prefixIcon: const Icon(Icons.search),
//                   hintText: 'Search music...',
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: const BorderSide(
//                       color: Colors.grey,
//                     ), // Default border color
//                   ),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: const BorderSide(
//                       color: Colors.grey,
//                     ), // Border when not focused
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: const BorderSide(
//                       color: Color.fromARGB(255, 158, 201, 236),
//                     ), // Border when focused
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: const BorderSide(
//                       color: Colors.red,
//                     ), // Border when error
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: const BorderSide(
//                       color: Colors.red,
//                     ), // Border when error and focused
//                   ),
//                 ),
//               ),
//             ),
//             // Music List (Observer)
//             Expanded(
//               child: Observer(
//                 builder: (_) {
//                   _MusicListStore.SelectedMusicList(subcategory['id']);

//                   if (_MusicListStore.fetchPostsFuture.status ==
//                           FutureStatus.pending &&
//                       _musicControllerStore.isInitialized) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (_MusicListStore.fetchPostsFuture.status ==
//                       FutureStatus.fulfilled) {
//                     allMusicList = _MusicListStore.AllMusic;

//                     if (allMusicList == null || allMusicList!.isEmpty) {
//                       return const Center(
//                         child: Text("No Music List available"),
//                       );
//                     }

//                     // Update filtered list on initial load
//                     if (_searchController.text.isEmpty) {
//                       filteredMusicList = allMusicList!;
//                       _musicControllerStore.AllMusic = allMusicList!;
//                     }

//                     return ListView.builder(
//                       itemCount: filteredMusicList.length,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             _musicControllerStore.playNext(
//                              currentIndex: index,
//                              nextplay: filteredMusicList[index],
//                             );
//                             Navigator.of(context).pushNamed(
//                               Routes.musicPlayer,
//                               arguments: filteredMusicList[index],
//                             );
//                           },
//                           child: MusicItems(index: index, music: filteredMusicList[index]),
//                         );
//                       },
//                     );
//                   } else {
//                     return const Center(child: Text("An error occurred"));
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//        bottomNavigationBar: Observer(
//         builder: (context) => IntrinsicHeight(
//           child: Column(
//             mainAxisSize:
//                 MainAxisSize.min, // Ensure the column takes only required height
//             children: [
//               _musicControllerStore.isDownloadedPlaying
//                   ? BottomDownloadedMusicPlayerBar(
//                     musicControllerStore: _musicControllerStore,
//                   )
//                   : BottomMusicPlayerBar(
//                     musicControllerStore: _musicControllerStore,
//                   ),
//               // AdsScreen(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
