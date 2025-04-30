
import 'package:boilerplate_new_version/core/domain/usecase/use_case.dart';
import 'package:boilerplate_new_version/data/repository/recent_play_list/recent_playlist_respository_imp.dart';


class DeleteRecentPlayListUseCase extends UseCase<int, String> {
  final RecentPlayListRespositoryImp _postRepository;

  DeleteRecentPlayListUseCase(this._postRepository);

  @override
  Future<int> call({required params}) {
    return _postRepository.delete(params);
  }
}