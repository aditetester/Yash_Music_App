import 'package:boilerplate_new_version/core/stores/error/error_store.dart';
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded.dart';
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded_list.dart';
import 'package:boilerplate_new_version/domain/usecase/downloaded_list/get_downloadedList_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/downloaded_list/insert_DownloadedList_usecase.dart';
import 'package:boilerplate_new_version/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
part 'download_list_store.g.dart';

class DownloadListStore = _downloadListStore with _$downloadListStore;

abstract class _downloadListStore with Store {
  DownloadedListModule? _currentdownloadedSong;

  @observable
  List<String>? _downloadedSongList = [];

  // store variables:-----------------------------------------------------------
  static ObservableFuture<AllDownloadedList?> emptyMusicListResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<AllDownloadedList?> fetchFuture =
      ObservableFuture<AllDownloadedList?>(emptyMusicListResponse);

  @observable
  List<DownloadedListModule>? AllDownloadedMusic;

  // use cases:-----------------------------------------------------------------
  final GetDownloadedMusiclistUsecase _getDownloadMusicListUseCase;
  final InsertMusicsUseCase _insertMusicsUseCase;

  // stores:--------------------------------------------------------------------
  final ErrorStore errorStore;

  // constructor:---------------------------------------------------------------
  _downloadListStore(
    this._getDownloadMusicListUseCase,
    this._insertMusicsUseCase,
    this.errorStore,
  );

  @computed
  List<String>? get getDownloadedList => _downloadedSongList;
  


  // actions:-------------------------------------------------------------------
  @action
  Future<void> fetchDownloadedMusicList() async {
    final future = _getDownloadMusicListUseCase.call(params: null);
    fetchFuture = ObservableFuture(future);

    await future
        .then((MusicList) {
          AllDownloadedMusic = MusicList.DownloadedListData;

          if (AllDownloadedMusic!.isNotEmpty) {
           _downloadedSongList = AllDownloadedMusic!.map((songs) {
              return songs.title.toString();
            }).toList();
          }
          print("objectdownload: $_downloadedSongList");

        })
        .catchError((error) {
          errorStore.errorMessage = DioExceptionUtil.handleError(error);
        });
  }

  @action
  Future<void> insertDownloadedMusicList(
    String id,
    String title,
    String subTitle,
    String audio,
  ) async {
    _currentdownloadedSong = DownloadedListModule(
      id: id,
      title: title,
      subtitle: subTitle,
      subCategoryId: "12",
      subCategoryName: "lofi",
      audio: audio,
      lyrics: "ddf",
    );

    final future = await _insertMusicsUseCase.call(
      params: _currentdownloadedSong!,
    );
    fetchDownloadedMusicList();
  }
}
