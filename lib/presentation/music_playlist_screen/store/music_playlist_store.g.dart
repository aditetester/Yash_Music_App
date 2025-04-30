// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_playlist_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MusicPlayListStore on _MusicPlayListStore, Store {
  Computed<List<String>?>? _$getPlayListSongComputed;

  @override
  List<String>? get getPlayListSong => (_$getPlayListSongComputed ??=
          Computed<List<String>?>(() => super.getPlayListSong,
              name: '_MusicPlayListStore.getPlayListSong'))
      .value;

  late final _$_PlayListSongAtom =
      Atom(name: '_MusicPlayListStore._PlayListSong', context: context);

  @override
  List<String>? get _PlayListSong {
    _$_PlayListSongAtom.reportRead();
    return super._PlayListSong;
  }

  @override
  set _PlayListSong(List<String>? value) {
    _$_PlayListSongAtom.reportWrite(value, super._PlayListSong, () {
      super._PlayListSong = value;
    });
  }

  late final _$fetchFutureAtom =
      Atom(name: '_MusicPlayListStore.fetchFuture', context: context);

  @override
  ObservableFuture<AllMusicList?> get fetchFuture {
    _$fetchFutureAtom.reportRead();
    return super.fetchFuture;
  }

  @override
  set fetchFuture(ObservableFuture<AllMusicList?> value) {
    _$fetchFutureAtom.reportWrite(value, super.fetchFuture, () {
      super.fetchFuture = value;
    });
  }

  late final _$AllMusicPlayListAtom =
      Atom(name: '_MusicPlayListStore.AllMusicPlayList', context: context);

  @override
  List<MusicListModule>? get AllMusicPlayList {
    _$AllMusicPlayListAtom.reportRead();
    return super.AllMusicPlayList;
  }

  @override
  set AllMusicPlayList(List<MusicListModule>? value) {
    _$AllMusicPlayListAtom.reportWrite(value, super.AllMusicPlayList, () {
      super.AllMusicPlayList = value;
    });
  }

  late final _$fetchMusicPlayListAsyncAction =
      AsyncAction('_MusicPlayListStore.fetchMusicPlayList', context: context);

  @override
  Future<void> fetchMusicPlayList() {
    return _$fetchMusicPlayListAsyncAction
        .run(() => super.fetchMusicPlayList());
  }

  late final _$insertMusicPlayListAsyncAction =
      AsyncAction('_MusicPlayListStore.insertMusicPlayList', context: context);

  @override
  Future<void> insertMusicPlayList(
      {required String id,
      required String title,
      required String subTitle,
      required String audio,
      required String image,
      required String lyrics,
      required String subCategoryId,
      required String subCategoryName}) {
    return _$insertMusicPlayListAsyncAction.run(() => super.insertMusicPlayList(
        id: id,
        title: title,
        subTitle: subTitle,
        audio: audio,
        image: image,
        lyrics: lyrics,
        subCategoryId: subCategoryId,
        subCategoryName: subCategoryName));
  }

  late final _$SelectedMusicListAsyncAction =
      AsyncAction('_MusicPlayListStore.SelectedMusicList', context: context);

  @override
  Future<void> SelectedMusicList(String subCategoryId) {
    return _$SelectedMusicListAsyncAction
        .run(() => super.SelectedMusicList(subCategoryId));
  }

  @override
  String toString() {
    return '''
fetchFuture: ${fetchFuture},
AllMusicPlayList: ${AllMusicPlayList},
getPlayListSong: ${getPlayListSong}
    ''';
  }
}
