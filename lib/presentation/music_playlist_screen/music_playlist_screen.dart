import 'package:boilerplate_new_version/constants/app_theme.dart';
import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/sub_categories/subCategory.dart';
import 'package:boilerplate_new_version/presentation/music_player/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/presentation/sub_categories/store/sub_categories_store.dart';
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
      itemCount: 3,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child:
              index == 0
                  ? Container(
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
                      children: [
                        Icon(Icons.add, color: Colors.white, size: 20),
                        Text(
                          "Add New Playlist",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                  : Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: EdgeInsets.zero,
                    child: Stack(
                      children: [
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // 2x2 Grid of images
                            Positioned.fill(
                              top: 0,
                              bottom: 50,
                              child: ClipRRect(

                                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16), bottomLeft: Radius.circular(16)),
                                child: GridView.count(
                                  padding: EdgeInsets.zero,
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  childAspectRatio: 2 / 1.3,
                                  mainAxisSpacing: 0,
                                  crossAxisSpacing: 0,
                                  children: [
                                    Image.asset(
                                      'assets/images/demo_img.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                    Image.asset(
                                      'assets/images/demo_img.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                    Image.asset(
                                      'assets/images/demo_img.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                    Image.asset(
                                      'assets/images/demo_img.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned.fill(
                          top: 110,
                          bottom: 0,
                          child: Container(
                            padding: EdgeInsets.only(left:  10, top: 10, right: 10),
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(bottomRight: Radius.circular(16), bottomLeft: Radius.circular(16))),
                            
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Power of Attitud',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,

                                      ),
                                    ),
                                    
                                    Text(
                                      '42 Songs',
                                      style: TextStyle(color: Colors.grey[600], fontFamily: 'Poppins',
                                        fontSize: 8,
                                        fontWeight: FontWeight.w400, ),
                                    ),
                                  ],
                                ),
                                // Play button aligned to bottom right
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blue,
                                    ),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                       
                      ],
                    ),
                  ),
        );
      },
    );
  }
}
