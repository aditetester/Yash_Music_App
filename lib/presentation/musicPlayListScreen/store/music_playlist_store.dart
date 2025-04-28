import 'package:boilerplate_new_version/core/stores/error/error_store.dart';
import 'package:boilerplate_new_version/data/network/apis/lyricsPlayer/lyricsPlayer_api.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';
import 'package:boilerplate_new_version/domain/usecase/music_playlist/get_downloadedList_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/music_playlist/insert_DownloadedList_usecase.dart';
import 'package:mobx/mobx.dart';
part 'music_playlist_store.g.dart';

class MusicPlayListStore = _MusicPlayListStore with _$MusicPlayListStore;

abstract class _MusicPlayListStore with Store {

  MusicListModule? _currentPlayListSong;
  final LyricsApi lyricsApi;

  @observable
  List<String>? _PlayListSong = [];

  // store variables:-----------------------------------------------------------
  static ObservableFuture<AllMusicList?> emptyMusicListResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<AllMusicList?> fetchFuture =
      ObservableFuture<AllMusicList?>(emptyMusicListResponse);

  @observable
  List<MusicListModule>? AllMusicPlayList;

  // use cases:-----------------------------------------------------------------
  final GetMusicPlayListUsecase _getMusicPlayListUsecase;
  final InsertMusicsPlayListUseCase _insertMusicsUseCase;

  // stores:--------------------------------------------------------------------
  final ErrorStore errorStore;

  // constructor:---------------------------------------------------------------
  _MusicPlayListStore(
    this._getMusicPlayListUsecase,
    this._insertMusicsUseCase,
    this.errorStore,
    this.lyricsApi,
  );

  @computed
  List<String>? get getPlayListSong => _PlayListSong;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> fetchMusicPlayList() async {
    final future = _getMusicPlayListUsecase.call(params: null);
    fetchFuture = ObservableFuture(future);

    await future
        .then((MusicList) {
          AllMusicPlayList = MusicList.MusicListData;

          if (AllMusicPlayList!.isNotEmpty) {
            _PlayListSong =
                AllMusicPlayList!.map((songs) {
                  return songs.title.toString();
                }).toList();
          }
        })
        .catchError((error) {
          errorStore.errorMessage = error;
        });
  }

  @action
  Future<void> insertMusicPlayList({
    required String id,
    required String title,
    required String subTitle,
    required String audio,
    required String image,
    required String lyrics,
    required String subCategoryId,
    required String subCategoryName,
  }) async {
    _currentPlayListSong = MusicListModule(
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
      params: _currentPlayListSong!,
    );
    fetchMusicPlayList();
  }

  @action
  Future<void> SelectedMusicList(String subCategoryId) async {
    AllMusicPlayList =  AllMusicPlayList!
            .where((element) => element.subCategoryId == subCategoryId)
            .toList();

  }
}
