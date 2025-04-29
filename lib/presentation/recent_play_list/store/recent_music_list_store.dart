import 'package:boilerplate_new_version/core/stores/error/error_store.dart';
import 'package:boilerplate_new_version/data/network/apis/lyricsPlayer/lyricsPlayer_api.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';
import 'package:boilerplate_new_version/domain/usecase/music_list/get_musicList_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/music_playlist/get_music_playlist_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/music_playlist/insert_music_playlist_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/recent_play_list/get_recent_playist_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/recent_play_list/insert_recent_playist_usecase.dart';
import 'package:boilerplate_new_version/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'recent_music_list_store.g.dart';

class RecentMusicListStore = _RecentMusicListStore with _$RecentMusicListStore;

abstract class _RecentMusicListStore with Store {

  final LyricsApi lyricsApi;

  // use cases:-----------------------------------------------------------------
  final GetRecentPlayListUsecase _getRecentMusicPlayListUsecase;
  final InsertRecentPlayListUseCase _insertMusicsUseCase;

  // stores:--------------------------------------------------------------------
  final ErrorStore errorStore;


  MusicListModule? _currentPlayListSong;


  // constructor:---------------------------------------------------------------
  _RecentMusicListStore(this._getRecentMusicPlayListUsecase, this._insertMusicsUseCase , this.errorStore ,this.lyricsApi);

  // store variables:-----------------------------------------------------------
  static ObservableFuture<AllMusicList?> emptyMusicListResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<AllMusicList?> fetchPostsFuture =
      ObservableFuture<AllMusicList?>(emptyMusicListResponse);

  @observable
  List<MusicListModule>? AllMusic;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> fetchRecentMusicList() async {
    final future = _getRecentMusicPlayListUsecase.call(params: null);
    fetchPostsFuture = ObservableFuture(future);

    await future
        .then((MusicList) {
          
          AllMusic = MusicList.MusicListData;
          
        })
        .catchError((error) {
           print("objobj: $error");
         errorStore.errorMessage = error;
        });
  }

  @action
  Future<void> insertRecentPlayList({
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

     await _insertMusicsUseCase.call(
      params: _currentPlayListSong!,
    );
   
    fetchRecentMusicList();
  }

}
