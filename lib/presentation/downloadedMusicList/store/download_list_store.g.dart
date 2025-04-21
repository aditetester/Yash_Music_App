// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$downloadListStore on _downloadListStore, Store {
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

  @override
  String toString() {
    return '''
fetchFuture: ${fetchFuture},
AllDownloadedMusic: ${AllDownloadedMusic}
    ''';
  }
}
