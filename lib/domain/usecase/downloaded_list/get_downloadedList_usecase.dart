
import 'package:boilerplate_new_version/core/domain/usecase/use_case.dart';
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded_list.dart';
import 'package:boilerplate_new_version/domain/repository/downloaded_list/downloadedList_repository.dart';

class GetDownloadedMusiclistUsecase extends UseCase<AllDownloadedList, void> {

  final downloadedListRepository _musicListRepository;

  GetDownloadedMusiclistUsecase(this._musicListRepository);

  @override
  Future<AllDownloadedList> call({required params}) {
    return _musicListRepository.getDownloadedMusicList();
  }
}