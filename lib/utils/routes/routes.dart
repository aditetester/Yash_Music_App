import 'package:boilerplate_new_version/presentation/downloaded_music_list/downloaded_musicList.dart';
import 'package:boilerplate_new_version/presentation/lyrics/lyricsPlayer_screen.dart';
import 'package:boilerplate_new_version/presentation/music/music_list.dart';
import 'package:boilerplate_new_version/presentation/music_playlist_screen/music_playlist_screen.dart';
import 'package:boilerplate_new_version/presentation/music_player/musicPlayer_DownloadedScreen.dart';
import 'package:boilerplate_new_version/presentation/music_player/musicPlayer_screen.dart';
import 'package:boilerplate_new_version/presentation/recent_play_list/recent_music_list.dart';
import 'package:boilerplate_new_version/presentation/search_music_screen/search_music_screen.dart';
import 'package:boilerplate_new_version/presentation/sub_categories/sub_category_list.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate_new_version/presentation/categories/category_list.dart';
import '../../presentation/home/home.dart';

class Routes {
  Routes._();

  //static variables
  static const String home = '/home';
  static const String searchMusicScreen = '/SearchMusicScreen';
  static const String categoryList = '/categroiesList';
  static const String subCategoryList = '/subCategroiesList';
  static const String musicList = '/musciList';
  static const String musicPlayer = '/musciPlayer';
  static const String lyricsPlayer = '/lyricsPlayer';
  static const String downloadedMusicPlayList = '/downloadedMusicPlayList';
  static const String musicPlayerDownloadedScreen =
      '/musicPlayerDownloadedScreen';
  static const String musicPlayListScreen = '/musicPlayListScreen';
  static const String recentMusicPlayListScreen = '/recentMusicPlayListScreen';
  

  static final routes = <String, WidgetBuilder>{
    home: (BuildContext context) => HomeScreen(),
    searchMusicScreen: (BuildContext context) => SearchMusicScreen(),
    categoryList: (BuildContext context) => CategoryList(),
    subCategoryList: (BuildContext context) => SubCategoryList(),
    musicList: (BuildContext context) => MusicList(),
    musicPlayer: (BuildContext context) => MusicPlayerScreen(),
    lyricsPlayer: (BuildContext context) => LyricsPlayerScreen(),
    downloadedMusicPlayList:
        (BuildContext context) => DownloadedMusicPlayList(),
    musicPlayerDownloadedScreen:
        (BuildContext context) => MusicPlayerDownloadedScreen(),
    musicPlayListScreen: (BuildContext context) => MusicPlayListScreen(),
    recentMusicPlayListScreen: (BuildContext context) => RecentMusicList()
    
  };
}
