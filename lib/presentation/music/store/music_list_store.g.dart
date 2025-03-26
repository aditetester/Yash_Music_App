// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_list_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MusicListStore on _MusicListStore, Store {
  late final _$fetchPostsFutureAtom =
      Atom(name: '_MusicListStore.fetchPostsFuture', context: context);

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

  late final _$AllMusicAtom =
      Atom(name: '_MusicListStore.AllMusic', context: context);

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

  late final _$fetchMusicListAsyncAction =
      AsyncAction('_MusicListStore.fetchMusicList', context: context);

  @override
  Future<void> fetchMusicList() {
    return _$fetchMusicListAsyncAction.run(() => super.fetchMusicList());
  }

  late final _$SelectedMusicListAsyncAction =
      AsyncAction('_MusicListStore.SelectedMusicList', context: context);

  @override
  Future<void> SelectedMusicList(String subCategoryId) {
    return _$SelectedMusicListAsyncAction
        .run(() => super.SelectedMusicList(subCategoryId));
  }

  @override
  String toString() {
    return '''
fetchPostsFuture: ${fetchPostsFuture},
AllMusic: ${AllMusic}
    ''';
  }
}
