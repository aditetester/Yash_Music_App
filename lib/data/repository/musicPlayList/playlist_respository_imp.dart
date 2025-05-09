import 'package:boilerplate_new_version/data/network/local/music_playlist.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';
import 'package:boilerplate_new_version/domain/repository/musicPlayList/playList_repository.dart';

class PlayListRespositoryImp extends PlayListRepository {
  // api objects
  final LocalMusicPlayList _LocalMusicPlayList;

  // constructor
  PlayListRespositoryImp(this._LocalMusicPlayList);

  @override
  Future<AllMusicList> getMusicPlayList() async {
    return await _LocalMusicPlayList.getMusicPlayList();
  }
  
  @override
  Future<int> insert(MusicListModule data) async {
   return await _LocalMusicPlayList.insertMusicPlayList(data);
  }
  
}
