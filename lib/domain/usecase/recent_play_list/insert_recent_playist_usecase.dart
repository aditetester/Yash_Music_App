
import 'package:boilerplate_new_version/core/domain/usecase/use_case.dart';
import 'package:boilerplate_new_version/data/repository/recent_play_list/recent_playlist_respository_imp.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';


class InsertRecentPlayListUseCase extends UseCase<int, MusicListModule> {
  final RecentPlayListRespositoryImp _postRepository;

  InsertRecentPlayListUseCase(this._postRepository);

  @override
  Future<int> call({required params}) {
    return _postRepository.insert(params);
  }
}