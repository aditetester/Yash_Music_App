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
  Computed<List<String>?>? _$getCategoryPlayListComputed;

  @override
  List<String>? get getCategoryPlayList => (_$getCategoryPlayListComputed ??=
          Computed<List<String>?>(() => super.getCategoryPlayList,
              name: '_MusicPlayListStore.getCategoryPlayList'))
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

  late final _$_categoryListAtom =
      Atom(name: '_MusicPlayListStore._categoryList', context: context);

  @override
  List<String>? get _categoryList {
    _$_categoryListAtom.reportRead();
    return super._categoryList;
  }

  @override
  set _categoryList(List<String>? value) {
    _$_categoryListAtom.reportWrite(value, super._categoryList, () {
      super._categoryList = value;
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

  late final _$AllCategoryListAtom =
      Atom(name: '_MusicPlayListStore.AllCategoryList', context: context);

  @override
  List<CategoryPlayListModule>? get AllCategoryList {
    _$AllCategoryListAtom.reportRead();
    return super.AllCategoryList;
  }

  @override
  set AllCategoryList(List<CategoryPlayListModule>? value) {
    _$AllCategoryListAtom.reportWrite(value, super.AllCategoryList, () {
      super.AllCategoryList = value;
    });
  }

  late final _$fetchFutureAtom =
      Atom(name: '_MusicPlayListStore.fetchFuture', context: context);

  @override
  ObservableFuture<AllCategoryPlayList?> get fetchFuture {
    _$fetchFutureAtom.reportRead();
    return super.fetchFuture;
  }

  @override
  set fetchFuture(ObservableFuture<AllCategoryPlayList?> value) {
    _$fetchFutureAtom.reportWrite(value, super.fetchFuture, () {
      super.fetchFuture = value;
    });
  }

  late final _$fetchFuture2Atom =
      Atom(name: '_MusicPlayListStore.fetchFuture2', context: context);

  @override
  ObservableFuture<AllMusicList?> get fetchFuture2 {
    _$fetchFuture2Atom.reportRead();
    return super.fetchFuture2;
  }

  @override
  set fetchFuture2(ObservableFuture<AllMusicList?> value) {
    _$fetchFuture2Atom.reportWrite(value, super.fetchFuture2, () {
      super.fetchFuture2 = value;
    });
  }

  late final _$fetchCategoryPlayListAsyncAction = AsyncAction(
      '_MusicPlayListStore.fetchCategoryPlayList',
      context: context);

  @override
  Future<void> fetchCategoryPlayList() {
    return _$fetchCategoryPlayListAsyncAction
        .run(() => super.fetchCategoryPlayList());
  }

  late final _$insertCategoryPlayListAsyncAction = AsyncAction(
      '_MusicPlayListStore.insertCategoryPlayList',
      context: context);

  @override
  Future<void> insertCategoryPlayList(
      {required String name, required String totalSongs}) {
    return _$insertCategoryPlayListAsyncAction.run(
        () => super.insertCategoryPlayList(name: name, totalSongs: totalSongs));
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
      required String subCategoryId,
      required String subCategoryName,
      required String lyrics}) {
    return _$insertMusicPlayListAsyncAction.run(() => super.insertMusicPlayList(
        id: id,
        title: title,
        subTitle: subTitle,
        audio: audio,
        image: image,
        subCategoryId: subCategoryId,
        subCategoryName: subCategoryName,
        lyrics: lyrics));
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
AllMusicPlayList: ${AllMusicPlayList},
AllCategoryList: ${AllCategoryList},
fetchFuture: ${fetchFuture},
fetchFuture2: ${fetchFuture2},
getPlayListSong: ${getPlayListSong},
getCategoryPlayList: ${getCategoryPlayList}
    ''';
  }
}
