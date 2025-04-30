import 'package:boilerplate_new_version/core/stores/error/error_store.dart';
import 'package:boilerplate_new_version/data/network/apis/lyrics/LyricsPlayer_api.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';
import 'package:boilerplate_new_version/domain/usecase/music_list/get_musicList_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/music_play_list/get_music_playlist_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/music_play_list/insert_music_playlist_usecase.dart';
import 'package:boilerplate_new_version/domain/usecase/recent_play_list/delete_recent_playist_usecase.dart';
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
  final DeleteRecentPlayListUseCase _deleteRecentPlayListUseCase;

  // stores:--------------------------------------------------------------------
  final ErrorStore errorStore;

  MusicListModule? _currentPlayListSong;

  @observable
  List<String>? _recentSongList = [];

  // constructor:---------------------------------------------------------------
  _RecentMusicListStore(
    this._getRecentMusicPlayListUsecase,
    this._deleteRecentPlayListUseCase,
    this._insertMusicsUseCase,
    this.errorStore,
    this.lyricsApi,
  );

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
          _recentSongList =
              AllMusic!.map((songs) {
                return songs.title.toString();
              }).toList();
        })
        .catchError((error) {
          print("objobj: $error");
          errorStore.errorMessage = error;
        });
    removeLastDuplicate();
  }

  @action
  Future<void> insertRecentPlayList({
    required String id,
    required String title,
    required String subTitle,
    required String audio,
    required String image,
    required String subCategoryId,
    required String subCategoryName,
    required String lyrics,
  }) async {
    _currentPlayListSong = MusicListModule(
      id: id,
      title: title,
      subtitle: subTitle,
      audio: audio,
      image: image,
      subCategoryId: subCategoryId,
      subCategoryName: subCategoryName,
      lyrics: lyrics,
    );

    await _insertMusicsUseCase.call(params: _currentPlayListSong!);

    fetchRecentMusicList();
  }

  void removeLastDuplicate() {
    if (_recentSongList == null) return;

    final seen = <String>{};
    final duplicates = <String>{};

    // First, find duplicates
    for (var song in _recentSongList!) {
      if (!seen.add(song)) {
        duplicates.add(song);
      }
    }

    // Then, remove the last occurrence of each duplicate
    for (var dup in duplicates) {
      final lastIndex = _recentSongList!.lastIndexOf(dup);
      if (lastIndex != -1) {
        _deleteRecentPlayListUseCase.call(
          params: AllMusic![lastIndex].id.toString(),
        );
        _recentSongList!.removeAt(lastIndex);
      }
    }
  }
}
