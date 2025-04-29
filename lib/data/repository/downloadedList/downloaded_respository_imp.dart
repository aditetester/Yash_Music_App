import 'package:boilerplate_new_version/data/network/local/downloaded_list.dart';
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded.dart';
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded_list.dart';
import 'package:boilerplate_new_version/domain/repository/downloaded_list/downloadedList_repository.dart';

class DownloadedRespositoryImp extends downloadedListRepository {
  // api objects
  final LocalDownloadedMusicList _DownloadedListApi;

  // constructor
  DownloadedRespositoryImp(this._DownloadedListApi);

  @override
  Future<AllDownloadedList> getDownloadedMusicList() async {
    return await _DownloadedListApi.getMusicList();
  }
  
  @override
  Future<int> insert(DownloadedListModule data) async {
   return await _DownloadedListApi.insertDownloadedMusic(data);
  }
  
}
