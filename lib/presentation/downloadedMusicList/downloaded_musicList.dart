import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded.dart';
import 'package:boilerplate_new_version/presentation/downloadedMusicList/store/download_list_store.dart';
import 'package:boilerplate_new_version/presentation/downloadedMusicList/widgets/download_music_items.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:boilerplate_new_version/widgets/bottom_downloadedMusicPlayer_bar.dart';
import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:sizer/sizer.dart';

class DownloadedMusicPlayList extends StatefulWidget {
  const DownloadedMusicPlayList({super.key});

  @override
  State<DownloadedMusicPlayList> createState() =>
      _DownloadedMusicPlayListState();
}

class _DownloadedMusicPlayListState extends State<DownloadedMusicPlayList> {
  final MusicControllerStore _musicControllerStore =
      getIt<MusicControllerStore>();
  final DownloadListStore _downloadListStore = getIt<DownloadListStore>();
  TextEditingController _searchController = TextEditingController();
  List<DownloadedListModule>? allMusicList = [];
  List<DownloadedListModule> filteredMusicList = [];

  @override
  void initState() {
    super.initState();

    _downloadListStore.fetchDownloadedMusicList();
    _searchController.addListener(_filterMusicList);
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
            allMusicList!.where((music) {
              final title = music.title!.toLowerCase();
              return title.contains(query);
            }).toList();
      });
    } else {
      // If the list is null or empty, ensure filteredMusicList is also empty
      setState(() {
        filteredMusicList = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //App Bar Section
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 15, right: 8.0),
              child: _builderTopArea(context, "Downloads".toString()),
            ),
            Expanded(child: _builderBodyArea(context, '')),

            // Categories Section
            // CategoryViewScreen(),
            // SizedBox(height: 15),
          ],
        ),
      ),
      bottomNavigationBar: Observer(
        builder:
            (context) => IntrinsicHeight(
              child: Column(
                mainAxisSize:
                    MainAxisSize
                        .min, // Ensure the column takes only required height
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

  Widget _builderTopArea(BuildContext context, String heading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // First Row: Back button and Title
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 15, right: 8.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Image.asset(
                  'assets/images/drawer_back_icon.png',
                  height: 7.5.h,
                  width: 7.5.w,
                ),
              ),
              SizedBox(width: 5),
              Text(
                heading,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),

        // Second Row: Tabs
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _downloadListStore.changeTab(0);
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "Downloads",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight:
                            _downloadListStore.getcurrentTabIndex == 0
                                ? FontWeight.w600
                                : FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 3,
                      width: 35.w,
                      color:
                          _downloadListStore.getcurrentTabIndex == 0
                              ? Colors.blue
                              : Colors.transparent,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 30),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _downloadListStore.changeTab(1);
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "Downloading",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight:
                            _downloadListStore.getcurrentTabIndex == 1
                                ? FontWeight.w600
                                : FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 5),
                    Container(
                      height: 3,
                      width: 35.w,
                      color:
                          _downloadListStore.getcurrentTabIndex == 1
                              ? Colors.blue
                              : Colors.transparent,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _builderBodyArea(BuildContext context, String subCategoryId) {
    return Expanded(
      child:
          _downloadListStore.getcurrentTabIndex == 0
              ? Observer(
                builder: (_) {
                  if (_downloadListStore.fetchFuture.status ==
                      FutureStatus.pending) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (_downloadListStore.fetchFuture.status ==
                      FutureStatus.fulfilled) {
                    allMusicList = _downloadListStore.AllDownloadedMusic;

                    if (allMusicList == null || allMusicList!.isEmpty) {
                      return const Center(
                        child: Text("No Music List available"),
                      );
                    }

                    if (_searchController.text.isEmpty) {
                      filteredMusicList = allMusicList!;
                      _musicControllerStore.AllDownloadedMusic = allMusicList!;
                    }

                    return ListView.builder(
                      itemCount: filteredMusicList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            _musicControllerStore.playDownloadNext(
                              currentIndex: index,
                              nextplay: filteredMusicList[index],
                            );
                            Navigator.of(context).pushNamed(
                              Routes.musicPlayerDownloadedScreen,
                              arguments: filteredMusicList[index],
                            );
                          },
                          child: DownloadedMusicItems(
                            index: index,
                            music: filteredMusicList[index],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text("An error occurred"));
                  }
                },
              )
              : Center(
                child: Text(
                  "No songs are downloading",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
    );
  }
}


//old UI-------------------------------------------------------------------------------------
// import 'package:boilerplate_new_version/di/service_locator.dart';
// import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded.dart';
// import 'package:boilerplate_new_version/presentation/downloadedMusicList/store/download_list_store.dart';
// import 'package:boilerplate_new_version/presentation/downloadedMusicList/widgets/download_music_items.dart';
// import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
// import 'package:boilerplate_new_version/utils/routes/routes.dart';
// import 'package:boilerplate_new_version/widgets/bottom_downloadedMusicPlayer_bar.dart';
// import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:mobx/mobx.dart';

// class DownloadedMusicPlayList extends StatefulWidget {
//   const DownloadedMusicPlayList({super.key});

//   @override
//   State<DownloadedMusicPlayList> createState() => _DownloadedMusicPlayListState();
// }

// class _DownloadedMusicPlayListState extends State<DownloadedMusicPlayList> {

//   final MusicControllerStore _musicControllerStore =
//       getIt<MusicControllerStore>();
//   final DownloadListStore _downloadListStore = getIt<DownloadListStore>();
//   TextEditingController _searchController = TextEditingController();
//   List<DownloadedListModule>? allMusicList = [];
//   List<DownloadedListModule> filteredMusicList = [];


//   @override
//   void initState() {
//     super.initState();
   
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
//     return Scaffold(
//       appBar: AppBar(title: Text('Downloaded Music List'), centerTitle: true),
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
                 
//                   if (_downloadListStore.fetchFuture.status ==
//                           FutureStatus.pending) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (_downloadListStore.fetchFuture.status ==
//                       FutureStatus.fulfilled) {
//                     allMusicList = _downloadListStore.AllDownloadedMusic;

//                     if (allMusicList == null || allMusicList!.isEmpty) {
//                       return const Center(
//                         child: Text("No Music List available"),
//                       );
//                     }

//                     // Update filtered list on initial load
//                     if (_searchController.text.isEmpty) {
//                       filteredMusicList = allMusicList!;
//                         _musicControllerStore.AllDownloadedMusic = allMusicList!;
//                     }

//                     return ListView.builder(
//                       itemCount: filteredMusicList.length,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             _musicControllerStore.playDownloadNext(
//                              _downloadListStore.getcurrentTabIndex:  index,
//                              nextplay:  filteredMusicList[index],
//                             );
//                             Navigator.of(context).pushNamed(
//                               Routes.musicPlayerDownloadedScreen,
//                               arguments: filteredMusicList[index],
//                             );
//                           },
//                           child: DownloadedMusicItems(index: index, music: filteredMusicList[index]),
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
