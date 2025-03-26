
import 'package:boilerplate_new_version/data/network/apis/musicList/musicList_api.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';
import 'package:boilerplate_new_version/domain/repository/music_list/musicList_respository.dart';

class MusicListRepositoryImp extends MusicListRepository {

  // api objects
  final MusicListApi _MusicListApi;

  // constructor
  MusicListRepositoryImp(this._MusicListApi);

  @override
  Future<AllMusicList> getMusicList() async {
    return await _MusicListApi.getMusicList();
  }
}
