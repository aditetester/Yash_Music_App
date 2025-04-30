import 'package:boilerplate_new_version/domain/entity/category_play_list/category.dart';
import 'package:boilerplate_new_version/domain/entity/category_play_list/category_play_list.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';

abstract class PlayListRepository {
  
  Future<AllCategoryPlayList> getCategoryPlayList();
  Future<int> insertCategory(CategoryPlayListModule params);

  Future<AllMusicList> getMusicPlayList();
  Future<int> insert(MusicListModule params);
}
