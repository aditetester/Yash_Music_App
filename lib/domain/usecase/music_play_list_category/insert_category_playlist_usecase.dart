import 'package:boilerplate_new_version/core/domain/usecase/use_case.dart';
import 'package:boilerplate_new_version/domain/entity/category_play_list/category.dart';
import 'package:boilerplate_new_version/domain/repository/music_play_list/playList_repository.dart';

class InsertCategoryPlayListUseCase
    extends UseCase<int, CategoryPlayListModule> {
  final PlayListRepository _postRepository;

  InsertCategoryPlayListUseCase(this._postRepository);

  @override
  Future<int> call({required params}) {
    return _postRepository.insertCategory(params);
  }
}
