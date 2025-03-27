// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_controller_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MusicControllerStore on _MusicControllerStore, Store {
  late final _$fetchPostsFutureAtom =
      Atom(name: '_MusicControllerStore.fetchPostsFuture', context: context);

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
      Atom(name: '_MusicControllerStore.AllMusic', context: context);

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

  late final _$_currentTrackIndexAtom =
      Atom(name: '_MusicControllerStore._currentTrackIndex', context: context);

  @override
  int get _currentTrackIndex {
    _$_currentTrackIndexAtom.reportRead();
    return super._currentTrackIndex;
  }

  @override
  set _currentTrackIndex(int value) {
    _$_currentTrackIndexAtom.reportWrite(value, super._currentTrackIndex, () {
      super._currentTrackIndex = value;
    });
  }

  late final _$_isPlayingAtom =
      Atom(name: '_MusicControllerStore._isPlaying', context: context);

  @override
  bool get _isPlaying {
    _$_isPlayingAtom.reportRead();
    return super._isPlaying;
  }

  @override
  set _isPlaying(bool value) {
    _$_isPlayingAtom.reportWrite(value, super._isPlaying, () {
      super._isPlaying = value;
    });
  }

  late final _$currentPositionAtom =
      Atom(name: '_MusicControllerStore.currentPosition', context: context);

  @override
  Duration get currentPosition {
    _$currentPositionAtom.reportRead();
    return super.currentPosition;
  }

  @override
  set currentPosition(Duration value) {
    _$currentPositionAtom.reportWrite(value, super.currentPosition, () {
      super.currentPosition = value;
    });
  }

  late final _$totalDurationAtom =
      Atom(name: '_MusicControllerStore.totalDuration', context: context);

  @override
  Duration get totalDuration {
    _$totalDurationAtom.reportRead();
    return super.totalDuration;
  }

  @override
  set totalDuration(Duration value) {
    _$totalDurationAtom.reportWrite(value, super.totalDuration, () {
      super.totalDuration = value;
    });
  }

  late final _$changeIsplayingAsyncAction =
      AsyncAction('_MusicControllerStore.changeIsplaying', context: context);

  @override
  Future<dynamic> changeIsplaying(bool value) {
    return _$changeIsplayingAsyncAction.run(() => super.changeIsplaying(value));
  }

  late final _$playAsyncAction =
      AsyncAction('_MusicControllerStore.play', context: context);

  @override
  Future<void> play() {
    return _$playAsyncAction.run(() => super.play());
  }

  late final _$pauseAsyncAction =
      AsyncAction('_MusicControllerStore.pause', context: context);

  @override
  Future<void> pause() {
    return _$pauseAsyncAction.run(() => super.pause());
  }

  late final _$playNextAsyncAction =
      AsyncAction('_MusicControllerStore.playNext', context: context);

  @override
  Future<void> playNext() {
    return _$playNextAsyncAction.run(() => super.playNext());
  }

  late final _$playPreviousAsyncAction =
      AsyncAction('_MusicControllerStore.playPrevious', context: context);

  @override
  Future<void> playPrevious() {
    return _$playPreviousAsyncAction.run(() => super.playPrevious());
  }

  late final _$seekAsyncAction =
      AsyncAction('_MusicControllerStore.seek', context: context);

  @override
  Future<void> seek(Duration position) {
    return _$seekAsyncAction.run(() => super.seek(position));
  }

  @override
  String toString() {
    return '''
fetchPostsFuture: ${fetchPostsFuture},
AllMusic: ${AllMusic},
currentPosition: ${currentPosition},
totalDuration: ${totalDuration}
    ''';
  }
}
