import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';

abstract class MusicListRepository {

  Future<AllMusicList> getMusicList();
  
  
}
