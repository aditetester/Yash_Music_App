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

class DownloadedMusicPlayList extends StatefulWidget {
  const DownloadedMusicPlayList({super.key});

  @override
  State<DownloadedMusicPlayList> createState() => _DownloadedMusicPlayListState();
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
      appBar: AppBar(title: Text('Downloaded Music List'), centerTitle: true),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search music...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ), // Default border color
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.grey,
                    ), // Border when not focused
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 158, 201, 236),
                    ), // Border when focused
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ), // Border when error
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.red,
                    ), // Border when error and focused
                  ),
                ),
              ),
            ),
            // Music List (Observer)
            Expanded(
              child: Observer(
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

                    // Update filtered list on initial load
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
                             currentIndex:  index,
                             nextplay:  filteredMusicList[index],
                            );
                            Navigator.of(context).pushNamed(
                              Routes.musicPlayerDownloadedScreen,
                              arguments: filteredMusicList[index],
                            );
                          },
                          child: DownloadedMusicItems(index: index, music: filteredMusicList[index]),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text("An error occurred"));
                  }
                },
              ),
            ),
          ],
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
}
