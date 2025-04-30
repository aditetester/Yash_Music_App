
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';

abstract class RecentPlayListRepository {

  Future<AllMusicList> getRecentPlayList();

  Future<int> insert(MusicListModule params);

  Future<int> delete(String params);
  
  
}