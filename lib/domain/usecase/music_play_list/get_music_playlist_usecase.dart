
import 'package:boilerplate_new_version/core/domain/usecase/use_case.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';
import 'package:boilerplate_new_version/domain/repository/music_play_list/playList_repository.dart';

class GetMusicPlayListUsecase extends UseCase<AllMusicList, void> {

  final PlayListRepository _musicListRepository;

  GetMusicPlayListUsecase(this._musicListRepository);

  @override
  Future<AllMusicList> call({required params}) {
    return _musicListRepository.getMusicPlayList();
  }
}