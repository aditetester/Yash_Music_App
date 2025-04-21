// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeControllerStore on _HomeControllerStore, Store {
  Computed<bool>? _$isSearchingComputed;

  @override
  bool get isSearching =>
      (_$isSearchingComputed ??= Computed<bool>(() => super.isSearching,
              name: '_HomeControllerStore.isSearching'))
          .value;
  Computed<List<String>>? _$recentlyPlayedSongsComputed;

  @override
  List<String> get recentlyPlayedSongs => (_$recentlyPlayedSongsComputed ??=
          Computed<List<String>>(() => super.recentlyPlayedSongs,
              name: '_HomeControllerStore.recentlyPlayedSongs'))
      .value;

  late final _$_isSearchingAtom =
      Atom(name: '_HomeControllerStore._isSearching', context: context);

  @override
  bool get _isSearching {
    _$_isSearchingAtom.reportRead();
    return super._isSearching;
  }

  @override
  set _isSearching(bool value) {
    _$_isSearchingAtom.reportWrite(value, super._isSearching, () {
      super._isSearching = value;
    });
  }

  late final _$_recentlyPlayedSongsAtom =
      Atom(name: '_HomeControllerStore._recentlyPlayedSongs', context: context);

  @override
  List<String> get _recentlyPlayedSongs {
    _$_recentlyPlayedSongsAtom.reportRead();
    return super._recentlyPlayedSongs;
  }

  @override
  set _recentlyPlayedSongs(List<String> value) {
    _$_recentlyPlayedSongsAtom.reportWrite(value, super._recentlyPlayedSongs,
        () {
      super._recentlyPlayedSongs = value;
    });
  }

  late final _$changeIsSearchAsyncAction =
      AsyncAction('_HomeControllerStore.changeIsSearch', context: context);

  @override
  Future<dynamic> changeIsSearch(bool value) {
    return _$changeIsSearchAsyncAction.run(() => super.changeIsSearch(value));
  }

  late final _$addRecentPlayAsyncAction =
      AsyncAction('_HomeControllerStore.addRecentPlay', context: context);

  @override
  Future<dynamic> addRecentPlay(String value) {
    return _$addRecentPlayAsyncAction.run(() => super.addRecentPlay(value));
  }

  @override
  String toString() {
    return '''
isSearching: ${isSearching},
recentlyPlayedSongs: ${recentlyPlayedSongs}
    ''';
  }
}
