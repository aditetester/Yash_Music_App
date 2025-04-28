
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';

abstract class PlayListRepository {

  Future<AllMusicList> getMusicPlayList();

  Future<int> insert(MusicListModule params);
  
  
}