
import 'package:boilerplate_new_version/core/stores/error/error_store.dart';
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded.dart';
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded_list.dart';
import 'package:boilerplate_new_version/domain/usecase/downloaded_list/get_downloadedList_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/downloaded_list/insert_DownloadedList_usecase.dart';
import 'package:boilerplate_new_version/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'download_list_store.g.dart';

class DownloadListStore = _downloadListStore with _$downloadListStore;

abstract class _downloadListStore with Store {
 
  // use cases:-----------------------------------------------------------------
  final GetDownloadedMusiclistUsecase _getDownloadMusicListUseCase;
  final InsertMusicsUseCase _insertMusicsUseCase;
  DownloadedListModule? _currentdownloadedSong;

  // stores:--------------------------------------------------------------------
  // store for handling errors
  final ErrorStore errorStore;

  // constructor:---------------------------------------------------------------
  _downloadListStore(this._getDownloadMusicListUseCase, this._insertMusicsUseCase,this.errorStore);

  // store variables:-----------------------------------------------------------
  static ObservableFuture<AllDownloadedList?> emptyMusicListResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<AllDownloadedList?> fetchFuture =
      ObservableFuture<AllDownloadedList?>(emptyMusicListResponse);

  @observable
  List<DownloadedListModule>? AllDownloadedMusic;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> fetchDownloadedMusicList() async {
    final future = _getDownloadMusicListUseCase.call(params: null);
    fetchFuture = ObservableFuture(future);
      
    await future.then((MusicList) {
      AllDownloadedMusic = MusicList.DownloadedListData;

     print("objectdownload: ${AllDownloadedMusic!.map((toElement){ print(toElement.title);})}");
    }).catchError((error) {
      errorStore.errorMessage = DioExceptionUtil.handleError(error);
    });
  }
  
  @action
  Future<void> insertDownloadedMusicList() async {
    _currentdownloadedSong  = DownloadedListModule(id: '1', title: "test",subtitle: "test", subCategoryId: "12" ,subCategoryName: "lofi",   audio: "", lyrics: "ddf");

    final future = await _insertMusicsUseCase.call(params: _currentdownloadedSong!);
    fetchDownloadedMusicList();
  }


}
