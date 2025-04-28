
import 'package:boilerplate_new_version/core/domain/usecase/use_case.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/domain/repository/musicPlayList/playList_repository.dart';


class InsertMusicsPlayListUseCase extends UseCase<int, MusicListModule> {
  final PlayListRepository _postRepository;

  InsertMusicsPlayListUseCase(this._postRepository);

  @override
  Future<int> call({required params}) {
    return _postRepository.insert(params);
  }
}