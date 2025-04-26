import 'dart:typed_data';

import 'package:boilerplate_new_version/core/stores/error/error_store.dart';
import 'package:boilerplate_new_version/data/network/apis/lyricsPlayer/lyricsPlayer_api.dart';
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded.dart';
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded_list.dart';
import 'package:boilerplate_new_version/domain/usecase/downloaded_list/get_downloadedList_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/downloaded_list/insert_DownloadedList_usecase.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:permission_handler/permission_handler.dart';
part 'download_list_store.g.dart';

class DownloadListStore = _downloadListStore with _$DownloadListStore;

abstract class _downloadListStore with Store {
  DownloadedListModule? _currentdownloadedSong;
  final LyricsApi lyricsApi;

  @observable
  int _currentTabIndex = 0;

  @observable
  List<String>? _downloadedSongList = [];

  // // variables:-----------------------------------------------------------
  // @observable
  // String musicUrl = "";
  // @observable
  // CancelToken? _cancelToken;
  // @observable
  // List<int> _partialData = [];
  // @observable
  // int _downloadedBytes = 0;
  // @observable
  // int _totalBytes = 0;
  // @observable
  // bool _downloading = false;
  // @observable
  // bool _paused = false;

  // @computed
  // String get getmusicUrl => musicUrl;
  // @computed
  // CancelToken? get getcancelToken => _cancelToken;
  // @computed
  // List<int> get getpartialData => _partialData;
  // @computed
  // int get getdownloadedBytes => _downloadedBytes;
  // @computed
  // int get gettotalBytes => _totalBytes;
  // @computed
  // bool get getdownloading => _downloading;
  // @computed
  // bool get getpaused => _paused;

  // @computed
  // double get progress => _totalBytes == 0 ? 0 : _downloadedBytes / _totalBytes;

  @computed
  int get getcurrentTabIndex => _currentTabIndex;

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
    this.lyricsApi,
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
            _downloadedSongList =
                AllDownloadedMusic!.map((songs) {
                  return songs.title.toString();
                }).toList();
          }
        })
        .catchError((error) {
          errorStore.errorMessage = error;
        });
  }

  @action
  Future<void> insertDownloadedMusicList({
    required String id,
    required String title,
    required String subTitle,
    required String audio,
    required String image,
    required String lyrics,
    required String subCategoryId,
    required String subCategoryName,
  }) async {
    _currentdownloadedSong = DownloadedListModule(
      id: id,
      title: title,
      subtitle: subTitle,
      audio: audio,
      image: image,
      lyrics: lyrics,
      subCategoryId: subCategoryId,
      subCategoryName: subCategoryName,
    );

    final future = await _insertMusicsUseCase.call(
      params: _currentdownloadedSong!,
    );
    fetchDownloadedMusicList();
  }

  // void setUrl(String url) {
  //   musicUrl = url;
  // }

  // void pauseDownload(bool boolval) {
  //   _paused = boolval;
  //   _cancelToken?.cancel();
  // }

  // void setData(bool isDownload, bool isPause) {
  //   _cancelToken = CancelToken();
  //   _downloading = isDownload;
  //   _paused = isPause;
  // }

  // void setBytes(int val) {
  //   _totalBytes = val;
  // }

  // void setelseByte(int total) {
  //   _totalBytes = total;
  //   _partialData.clear();
  //   _downloadedBytes = 0;
  // }

  // void setChunk(Uint8List chunk) {
  //   _partialData.addAll(chunk);
  //   _downloadedBytes += chunk.length;
  // }

  // void onFinish() {
  //   _downloading = false;
  //   _paused = false;
  //   _partialData.clear();
  //   _downloadedBytes = 0;
  //   _totalBytes = 0;
  // }
  @action
  Future<void> changeTab(int val) async {
    _currentTabIndex = val;
  }

  @action
  Future<String> getLyricsData(String url) async {
    return await lyricsApi.getLyrics(url);
  }
}
