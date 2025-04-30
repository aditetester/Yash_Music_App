import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/presentation/music/widgets/music_items.dart';
import 'package:boilerplate_new_version/presentation/music_player/store/musicController/music_controller_store.dart';
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

class RecentMusicList extends StatefulWidget {
  const RecentMusicList({super.key});

  @override
  State<RecentMusicList> createState() => _MusicListState();
}

class _MusicListState extends State<RecentMusicList> {
  final RecentMusicListStore _MusicListStore = getIt<RecentMusicListStore>();
  final MusicControllerStore _musicControllerStore = getIt<MusicControllerStore>();



  List<MusicListModule>? allMusicList = [];
  bool showShimmer = true;

  @override
  void initState() {
    super.initState();
    _MusicListStore.fetchRecentMusicList();

    Timer(Duration(seconds: 2), () {
      setState(() {
        showShimmer = false;
      });
    });
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
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 15, right: 8.0),
              child: _builderTopArea(context, "Recent Play"),
            ),
            Expanded(
              child: _builderBodyArea(context, ''),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Observer(
        builder: (context) => IntrinsicHeight(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _musicControllerStore.isDownloadedPlaying
                  ? BottomDownloadedMusicPlayerBar(musicControllerStore: _musicControllerStore)
                  : BottomMusicPlayerBar(musicControllerStore: _musicControllerStore),
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
              "$heading",
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
        if (showShimmer) {
          allMusicList = _MusicListStore.AllMusic;
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 6,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
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

        _musicControllerStore.AllMusic = allMusicList!;

        return ListView.builder(
          padding: EdgeInsets.zero,
          itemCount:allMusicList!.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _musicControllerStore.playNext(
                  currentIndex: index,
                  nextplay: allMusicList![index],
                );
                Navigator.of(context).pushNamed(
                  Routes.musicPlayer,
                  arguments: allMusicList![index],
                );
              },
              child: MusicItems(
                totalDuration: "00:00",
                index: index,
                music: allMusicList![index],
              ),
            );
          },
        );
      },
    );
  }
}

