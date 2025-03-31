import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/presentation/ads/ads_screen.dart';
import 'package:boilerplate_new_version/presentation/music/store/music_list_store.dart';
import 'package:boilerplate_new_version/presentation/music/widgets/music_items.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/widgets/musicPlayer_handler.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';

class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  MusicListStore _MusicListStore = getIt<MusicListStore>();
  final MusicControllerStore _musicControllerStore =
      getIt<MusicControllerStore>();
  TextEditingController _searchController = TextEditingController();
  List<MusicListModule>? allMusicList = [];
  List<MusicListModule> filteredMusicList = [];

  @override
  void initState() {
    super.initState();
    _MusicListStore.fetchMusicList();
    // Add a listener to the search controller
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
    final String subcategoryId =
    // ModalRoute.of(context)!.settings.arguments as String;
         "6715f190725b819f0474bbd9";
    return Scaffold(
      appBar: AppBar(title: Text('Music List'), centerTitle: true),
      body: Column(
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
                _MusicListStore.SelectedMusicList(subcategoryId);

                if (_MusicListStore.fetchPostsFuture.status ==
                    FutureStatus.pending && _musicControllerStore.isInitialized) {
                  return const Center(child: CircularProgressIndicator());
                } else if (_MusicListStore.fetchPostsFuture.status ==
                    FutureStatus.fulfilled) {
                  allMusicList = _MusicListStore.AllMusic;

                  if (allMusicList == null || allMusicList!.isEmpty) {
                    return const Center(child: Text("No Music List available"));
                  }

                  // Update filtered list on initial load
                  if (_searchController.text.isEmpty) {
                    filteredMusicList = allMusicList!;
                  }

                  return ListView.builder(
                    itemCount: filteredMusicList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap:
                            ()  {
                         
                             _musicControllerStore.playNext(filteredMusicList[index]);
                            
                             Navigator.of(context).pushNamed(Routes.musicPlayer, arguments: filteredMusicList[index]);
                            } , 
                        child: MusicItems(
                         music:  filteredMusicList[index],
                        ),
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
      bottomNavigationBar: IntrinsicHeight(
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Ensure the column takes only required height
          children: [
            BottomMusicPlayerBar(musicControllerStore: _musicControllerStore),
            // AdsScreen(),
          ],
        ),
      ),
    );
  }
}
