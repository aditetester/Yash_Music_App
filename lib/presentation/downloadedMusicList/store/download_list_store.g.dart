// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DownloadListStore on _downloadListStore, Store {
  Computed<List<String>?>? _$getDownloadedListComputed;

  @override
  List<String>? get getDownloadedList => (_$getDownloadedListComputed ??=
          Computed<List<String>?>(() => super.getDownloadedList,
              name: '_downloadListStore.getDownloadedList'))
      .value;

  late final _$_downloadedSongListAtom =
      Atom(name: '_downloadListStore._downloadedSongList', context: context);

  @override
  List<String>? get _downloadedSongList {
    _$_downloadedSongListAtom.reportRead();
    return super._downloadedSongList;
  }

  @override
  set _downloadedSongList(List<String>? value) {
    _$_downloadedSongListAtom.reportWrite(value, super._downloadedSongList, () {
      super._downloadedSongList = value;
    });
  }

  late final _$fetchFutureAtom =
      Atom(name: '_downloadListStore.fetchFuture', context: context);

  @override
  ObservableFuture<AllDownloadedList?> get fetchFuture {
    _$fetchFutureAtom.reportRead();
    return super.fetchFuture;
  }

  @override
  set fetchFuture(ObservableFuture<AllDownloadedList?> value) {
    _$fetchFutureAtom.reportWrite(value, super.fetchFuture, () {
      super.fetchFuture = value;
    });
  }

  late final _$AllDownloadedMusicAtom =
      Atom(name: '_downloadListStore.AllDownloadedMusic', context: context);

  @override
  List<DownloadedListModule>? get AllDownloadedMusic {
    _$AllDownloadedMusicAtom.reportRead();
    return super.AllDownloadedMusic;
  }

  @override
  set AllDownloadedMusic(List<DownloadedListModule>? value) {
    _$AllDownloadedMusicAtom.reportWrite(value, super.AllDownloadedMusic, () {
      super.AllDownloadedMusic = value;
    });
  }

  late final _$fetchDownloadedMusicListAsyncAction = AsyncAction(
      '_downloadListStore.fetchDownloadedMusicList',
      context: context);

  @override
  Future<void> fetchDownloadedMusicList() {
    return _$fetchDownloadedMusicListAsyncAction
        .run(() => super.fetchDownloadedMusicList());
  }

  late final _$insertDownloadedMusicListAsyncAction = AsyncAction(
      '_downloadListStore.insertDownloadedMusicList',
      context: context);

  @override
  Future<void> insertDownloadedMusicList(
      String id, String title, String subTitle, String audio) {
    return _$insertDownloadedMusicListAsyncAction
        .run(() => super.insertDownloadedMusicList(id, title, subTitle, audio));
  }

  @override
  String toString() {
    return '''
fetchFuture: ${fetchFuture},
AllDownloadedMusic: ${AllDownloadedMusic},
getDownloadedList: ${getDownloadedList}
    ''';
  }
}
