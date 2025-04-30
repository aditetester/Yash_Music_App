// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_music_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RecentMusicListStore on _RecentMusicListStore, Store {
  late final _$_recentSongListAtom =
      Atom(name: '_RecentMusicListStore._recentSongList', context: context);

  @override
  List<String>? get _recentSongList {
    _$_recentSongListAtom.reportRead();
    return super._recentSongList;
  }

  @override
  set _recentSongList(List<String>? value) {
    _$_recentSongListAtom.reportWrite(value, super._recentSongList, () {
      super._recentSongList = value;
    });
  }

  late final _$AllMusicAtom =
      Atom(name: '_RecentMusicListStore.AllMusic', context: context);

  @override
  List<MusicListModule>? get AllMusic {
    _$AllMusicAtom.reportRead();
    return super.AllMusic;
  }

  @override
  set AllMusic(List<MusicListModule>? value) {
    _$AllMusicAtom.reportWrite(value, super.AllMusic, () {
      super.AllMusic = value;
    });
  }

  late final _$fetchPostsFutureAtom =
      Atom(name: '_RecentMusicListStore.fetchPostsFuture', context: context);

  @override
  ObservableFuture<AllMusicList?> get fetchPostsFuture {
    _$fetchPostsFutureAtom.reportRead();
    return super.fetchPostsFuture;
  }

  @override
  set fetchPostsFuture(ObservableFuture<AllMusicList?> value) {
    _$fetchPostsFutureAtom.reportWrite(value, super.fetchPostsFuture, () {
      super.fetchPostsFuture = value;
    });
  }

  late final _$fetchRecentMusicListAsyncAction = AsyncAction(
      '_RecentMusicListStore.fetchRecentMusicList',
      context: context);

  @override
  Future<void> fetchRecentMusicList() {
    return _$fetchRecentMusicListAsyncAction
        .run(() => super.fetchRecentMusicList());
  }

  late final _$insertRecentPlayListAsyncAction = AsyncAction(
      '_RecentMusicListStore.insertRecentPlayList',
      context: context);

  @override
  Future<void> insertRecentPlayList(
      {required String id,
      required String title,
      required String subTitle,
      required String audio,
      required String image,
      required String subCategoryId,
      required String subCategoryName,
      required String lyrics}) {
    return _$insertRecentPlayListAsyncAction.run(() => super
        .insertRecentPlayList(
            id: id,
            title: title,
            subTitle: subTitle,
            audio: audio,
            image: image,
            subCategoryId: subCategoryId,
            subCategoryName: subCategoryName,
            lyrics: lyrics));
  }

  @override
  String toString() {
    return '''
AllMusic: ${AllMusic},
fetchPostsFuture: ${fetchPostsFuture}
    ''';
  }
}
