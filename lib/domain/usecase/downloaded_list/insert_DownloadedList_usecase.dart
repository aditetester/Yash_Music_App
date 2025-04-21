
import 'package:boilerplate_new_version/core/domain/usecase/use_case.dart';
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded.dart';
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded_list.dart';
import 'package:boilerplate_new_version/domain/repository/downloaded_list/downloadedList_repository.dart';


class InsertMusicsUseCase extends UseCase<int, DownloadedListModule> {
  final downloadedListRepository _postRepository;

  InsertMusicsUseCase(this._postRepository);

  @override
  Future<int> call({required params}) {
    return _postRepository.insert(params);
  }
}