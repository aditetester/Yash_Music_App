import 'package:boilerplate_new_version/constants/app_theme.dart';
import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/subCategories/subCategory.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/presentation/subCategories/store/sub_categories_store.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:boilerplate_new_version/widgets/bottom_downloadedMusicPlayer_bar.dart';
import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:sizer/sizer.dart';
import 'package:shimmer/shimmer.dart'; // << added shimmer import

class MusicPlayListScreen extends StatefulWidget {
  const MusicPlayListScreen({super.key});

  @override
  State<MusicPlayListScreen> createState() => _MusicPlayListScreenState();
}

class _MusicPlayListScreenState extends State<MusicPlayListScreen> {
  final MusicControllerStore _musicControllerStore =
      getIt<MusicControllerStore>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xC7DFDDEA),
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 15, right: 20),
                  child: Column(
                    children: [
                      _builderTopArea(context, "My Playlist"),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _builderBodyArea(context, ''),
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
                ),
              ],
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
    );
  }

  Widget _builderTopArea(BuildContext context, String heading) {
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
                  Navigator.of(context).pop();
                },
                icon: Image.asset(
                  'assets/images/drawer_back_icon.png',
                  height: 7.5.h,
                  width: 7.5.w,
                ),
              );
            },
          ),
          SizedBox(width: 5),
          Expanded(
            child: Container(
              height: 4.h,
              alignment: Alignment.centerLeft,
              child: Text(
                heading,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _builderBodyArea(BuildContext context, String categoryId) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 1,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 29, 162, 244),
                  Color.fromARGB(255, 29, 162, 244),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [Icon(Icons.add, color: Colors.white, size: 20), Text("Add New Playlist", style: TextStyle(fontFamily: 'Poppins', fontSize: 12, color: Colors.white),)],
            ),
          ),
        );
      },
    );
  }
}
