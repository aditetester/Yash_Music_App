
import 'package:boilerplate_new_version/core/domain/usecase/use_case.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';
import 'package:boilerplate_new_version/domain/repository/recent_play_list/recent_play_list_repository.dart';

class GetRecentPlayListUsecase extends UseCase<AllMusicList, void> {

  final RecentPlayListRepository _musicListRepository;

  GetRecentPlayListUsecase(this._musicListRepository);

  @override
  Future<AllMusicList> call({required params}) {
    return _musicListRepository.getRecentPlayList();
  }
}