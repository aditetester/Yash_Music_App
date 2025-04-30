import 'package:boilerplate_new_version/core/domain/usecase/use_case.dart';
import 'package:boilerplate_new_version/domain/entity/category_play_list/category_play_list.dart';
import 'package:boilerplate_new_version/domain/repository/music_play_list/playList_repository.dart';

class GetCategoryPlayListUsecase extends UseCase<AllCategoryPlayList, void> {
  final PlayListRepository _musicListRepository;

  GetCategoryPlayListUsecase(this._musicListRepository);

  @override
  Future<AllCategoryPlayList> call({required params}) {
    return _musicListRepository.getCategoryPlayList();
  }
}
