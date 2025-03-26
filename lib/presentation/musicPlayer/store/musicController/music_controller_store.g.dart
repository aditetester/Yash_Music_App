// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_controller_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MusicControllerStore on _MusicControllerStore, Store {
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

  late final _$changeIsPlayingAsyncAction =
      AsyncAction('_MusicControllerStore.changeIsPlaying', context: context);

  @override
  Future<void> changeIsPlaying(bool value) {
    return _$changeIsPlayingAsyncAction.run(() => super.changeIsPlaying(value));
  }

  late final _$playAsyncAction =
      AsyncAction('_MusicControllerStore.play', context: context);

  @override
  Future<void> play(String url) {
    return _$playAsyncAction.run(() => super.play(url));
  }

  late final _$pauseAsyncAction =
      AsyncAction('_MusicControllerStore.pause', context: context);

  @override
  Future<void> pause() {
    return _$pauseAsyncAction.run(() => super.pause());
  }

  late final _$seekAsyncAction =
      AsyncAction('_MusicControllerStore.seek', context: context);

  @override
  Future<void> seek(Duration position) {
    return _$seekAsyncAction.run(() => super.seek(position));
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

  late final _$_MusicControllerStoreActionController =
      ActionController(name: '_MusicControllerStore', context: context);

  @override
  void addToPlaylist(String title, String url) {
    final _$actionInfo = _$_MusicControllerStoreActionController.startAction(
        name: '_MusicControllerStore.addToPlaylist');
    try {
      return super.addToPlaylist(title, url);
    } finally {
      _$_MusicControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeFromPlaylist(int index) {
    final _$actionInfo = _$_MusicControllerStoreActionController.startAction(
        name: '_MusicControllerStore.removeFromPlaylist');
    try {
      return super.removeFromPlaylist(index);
    } finally {
      _$_MusicControllerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPosition: ${currentPosition},
totalDuration: ${totalDuration}
    ''';
  }
}
