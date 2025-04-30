import 'package:boilerplate_new_version/data/network/local/recent_music_list.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';
import 'package:boilerplate_new_version/domain/repository/recent_play_list/recent_play_list_repository.dart';

class RecentPlayListRespositoryImp extends RecentPlayListRepository {
  // api objects
  final LocalRecentPlayList _localRecentPlayList;

  // constructor
  RecentPlayListRespositoryImp(this._localRecentPlayList);

  @override
  Future<AllMusicList> getRecentPlayList() async {
    return await _localRecentPlayList.getRecentPlayList();
  }
  
  @override
  Future<int> insert(MusicListModule data) async {
   return await _localRecentPlayList.insertRecentPlayList(data);
  }
  
}
