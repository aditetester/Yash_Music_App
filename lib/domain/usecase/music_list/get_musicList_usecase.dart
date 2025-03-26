
import 'package:boilerplate_new_version/core/domain/usecase/use_case.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';
import 'package:boilerplate_new_version/domain/repository/music_list/musicList_respository.dart';


class GetMusiclistUsecase extends UseCase<AllMusicList, void> {

  final MusicListRepository _musicListRepository;

  GetMusiclistUsecase(this._musicListRepository);

  @override
  Future<AllMusicList> call({required params}) {
    return _musicListRepository.getMusicList();
  }
}