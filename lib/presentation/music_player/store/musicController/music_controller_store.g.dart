// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_controller_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MusicControllerStore on _MusicControllerStore, Store {
  Computed<bool>? _$isPlayingComputed;

  @override
  bool get isPlaying =>
      (_$isPlayingComputed ??= Computed<bool>(() => super.isPlaying,
              name: '_MusicControllerStore.isPlaying'))
          .value;
  Computed<bool>? _$isLyricsComputed;

  @override
  bool get isLyrics =>
      (_$isLyricsComputed ??= Computed<bool>(() => super.isLyrics,
              name: '_MusicControllerStore.isLyrics'))
          .value;
  Computed<bool>? _$isDownloadedPlayingComputed;

  @override
  bool get isDownloadedPlaying => (_$isDownloadedPlayingComputed ??=
          Computed<bool>(() => super.isDownloadedPlaying,
              name: '_MusicControllerStore.isDownloadedPlaying'))
      .value;
  Computed<int>? _$getCurrentMusicIndexComputed;

  @override
  int get getCurrentMusicIndex => (_$getCurrentMusicIndexComputed ??=
          Computed<int>(() => super.getCurrentMusicIndex,
              name: '_MusicControllerStore.getCurrentMusicIndex'))
      .value;
  Computed<String>? _$recentPlayComputed;

  @override
  String get recentPlay =>
      (_$recentPlayComputed ??= Computed<String>(() => super.recentPlay,
              name: '_MusicControllerStore.recentPlay'))
          .value;
  Computed<MusicListModule>? _$recentMusicComputed;

  @override
  MusicListModule get recentMusic => (_$recentMusicComputed ??=
          Computed<MusicListModule>(() => super.recentMusic,
              name: '_MusicControllerStore.recentMusic'))
      .value;
  Computed<DownloadedListModule>? _$recentDownloadedMusicPlayComputed;

  @override
  DownloadedListModule get recentDownloadedMusicPlay =>
      (_$recentDownloadedMusicPlayComputed ??= Computed<DownloadedListModule>(
              () => super.recentDownloadedMusicPlay,
              name: '_MusicControllerStore.recentDownloadedMusicPlay'))
          .value;
  Computed<AudioHandler?>? _$getAudioHandlerComputed;

  @override
  AudioHandler? get getAudioHandler => (_$getAudioHandlerComputed ??=
          Computed<AudioHandler?>(() => super.getAudioHandler,
              name: '_MusicControllerStore.getAudioHandler'))
      .value;
  Computed<AudioPlayer>? _$getAudioPlayerComputed;

  @override
  AudioPlayer get getAudioPlayer => (_$getAudioPlayerComputed ??=
          Computed<AudioPlayer>(() => super.getAudioPlayer,
              name: '_MusicControllerStore.getAudioPlayer'))
      .value;
  Computed<String>? _$getrecentLyricsComputed;

  @override
  String get getrecentLyrics => (_$getrecentLyricsComputed ??= Computed<String>(
          () => super.getrecentLyrics,
          name: '_MusicControllerStore.getrecentLyrics'))
      .value;

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

  late final _$AllDownloadedMusicAtom =
      Atom(name: '_MusicControllerStore.AllDownloadedMusic', context: context);

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

  late final _$_currentMusicIndexAtom =
      Atom(name: '_MusicControllerStore._currentMusicIndex', context: context);

  @override
  int get _currentMusicIndex {
    _$_currentMusicIndexAtom.reportRead();
    return super._currentMusicIndex;
  }

  @override
  set _currentMusicIndex(int value) {
    _$_currentMusicIndexAtom.reportWrite(value, super._currentMusicIndex, () {
      super._currentMusicIndex = value;
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

  late final _$_isLyricsAtom =
      Atom(name: '_MusicControllerStore._isLyrics', context: context);

  @override
  bool get _isLyrics {
    _$_isLyricsAtom.reportRead();
    return super._isLyrics;
  }

  @override
  set _isLyrics(bool value) {
    _$_isLyricsAtom.reportWrite(value, super._isLyrics, () {
      super._isLyrics = value;
    });
  }

  late final _$_isDownloadedPlayingAtom = Atom(
      name: '_MusicControllerStore._isDownloadedPlaying', context: context);

  @override
  bool get _isDownloadedPlaying {
    _$_isDownloadedPlayingAtom.reportRead();
    return super._isDownloadedPlaying;
  }

  @override
  set _isDownloadedPlaying(bool value) {
    _$_isDownloadedPlayingAtom.reportWrite(value, super._isDownloadedPlaying,
        () {
      super._isDownloadedPlaying = value;
    });
  }

  late final _$_recentPlayAtom =
      Atom(name: '_MusicControllerStore._recentPlay', context: context);

  @override
  String get _recentPlay {
    _$_recentPlayAtom.reportRead();
    return super._recentPlay;
  }

  @override
  set _recentPlay(String value) {
    _$_recentPlayAtom.reportWrite(value, super._recentPlay, () {
      super._recentPlay = value;
    });
  }

  late final _$_recentLyricsAtom =
      Atom(name: '_MusicControllerStore._recentLyrics', context: context);

  @override
  String get _recentLyrics {
    _$_recentLyricsAtom.reportRead();
    return super._recentLyrics;
  }

  @override
  set _recentLyrics(String value) {
    _$_recentLyricsAtom.reportWrite(value, super._recentLyrics, () {
      super._recentLyrics = value;
    });
  }

  late final _$_recentMusicAtom =
      Atom(name: '_MusicControllerStore._recentMusic', context: context);

  @override
  MusicListModule get _recentMusic {
    _$_recentMusicAtom.reportRead();
    return super._recentMusic;
  }

  @override
  set _recentMusic(MusicListModule value) {
    _$_recentMusicAtom.reportWrite(value, super._recentMusic, () {
      super._recentMusic = value;
    });
  }

  late final _$_recentDownloadedMusicPlayAtom = Atom(
      name: '_MusicControllerStore._recentDownloadedMusicPlay',
      context: context);

  @override
  DownloadedListModule get _recentDownloadedMusicPlay {
    _$_recentDownloadedMusicPlayAtom.reportRead();
    return super._recentDownloadedMusicPlay;
  }

  @override
  set _recentDownloadedMusicPlay(DownloadedListModule value) {
    _$_recentDownloadedMusicPlayAtom
        .reportWrite(value, super._recentDownloadedMusicPlay, () {
      super._recentDownloadedMusicPlay = value;
    });
  }

  late final _$_audioHandlerAtom =
      Atom(name: '_MusicControllerStore._audioHandler', context: context);

  @override
  AudioHandler? get _audioHandler {
    _$_audioHandlerAtom.reportRead();
    return super._audioHandler;
  }

  @override
  set _audioHandler(AudioHandler? value) {
    _$_audioHandlerAtom.reportWrite(value, super._audioHandler, () {
      super._audioHandler = value;
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

  late final _$isInitializedAtom =
      Atom(name: '_MusicControllerStore.isInitialized', context: context);

  @override
  bool get isInitialized {
    _$isInitializedAtom.reportRead();
    return super.isInitialized;
  }

  @override
  set isInitialized(bool value) {
    _$isInitializedAtom.reportWrite(value, super.isInitialized, () {
      super.isInitialized = value;
    });
  }

  late final _$initAudioServiceAsyncAction =
      AsyncAction('_MusicControllerStore.initAudioService', context: context);

  @override
  Future<void> initAudioService() {
    return _$initAudioServiceAsyncAction.run(() => super.initAudioService());
  }

  late final _$lyricsdataAsyncAction =
      AsyncAction('_MusicControllerStore.lyricsdata', context: context);

  @override
  Future<void> lyricsdata() {
    return _$lyricsdataAsyncAction.run(() => super.lyricsdata());
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
  Future<void> play(String musicUrl) {
    return _$playAsyncAction.run(() => super.play(musicUrl));
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
  Future<void> playNext(
      {required int currentIndex, required MusicListModule nextplay}) {
    return _$playNextAsyncAction.run(
        () => super.playNext(currentIndex: currentIndex, nextplay: nextplay));
  }

  late final _$playPreviousAsyncAction =
      AsyncAction('_MusicControllerStore.playPrevious', context: context);

  @override
  Future<void> playPrevious(
      {required int currentIndex, required MusicListModule previoudPlay}) {
    return _$playPreviousAsyncAction.run(() => super
        .playPrevious(currentIndex: currentIndex, previoudPlay: previoudPlay));
  }

  late final _$seekAsyncAction =
      AsyncAction('_MusicControllerStore.seek', context: context);

  @override
  Future<void> seek(Duration position) {
    return _$seekAsyncAction.run(() => super.seek(position));
  }

  late final _$lyricsDownloadeddataAsyncAction = AsyncAction(
      '_MusicControllerStore.lyricsDownloadeddata',
      context: context);

  @override
  Future<void> lyricsDownloadeddata() {
    return _$lyricsDownloadeddataAsyncAction
        .run(() => super.lyricsDownloadeddata());
  }

  late final _$playDownloadedAsyncAction =
      AsyncAction('_MusicControllerStore.playDownloaded', context: context);

  @override
  Future<void> playDownloaded(String musicUrl) {
    return _$playDownloadedAsyncAction
        .run(() => super.playDownloaded(musicUrl));
  }

  late final _$playDownloadNextAsyncAction =
      AsyncAction('_MusicControllerStore.playDownloadNext', context: context);

  @override
  Future<void> playDownloadNext(
      {required int currentIndex, required DownloadedListModule nextplay}) {
    return _$playDownloadNextAsyncAction.run(() =>
        super.playDownloadNext(currentIndex: currentIndex, nextplay: nextplay));
  }

  late final _$playDownloadPreviousAsyncAction = AsyncAction(
      '_MusicControllerStore.playDownloadPrevious',
      context: context);

  @override
  Future<void> playDownloadPrevious(
      {required int currentIndex, required DownloadedListModule previoudPlay}) {
    return _$playDownloadPreviousAsyncAction.run(() => super
        .playDownloadPrevious(
            currentIndex: currentIndex, previoudPlay: previoudPlay));
  }

  late final _$ChangeIsLyricsAsyncAction =
      AsyncAction('_MusicControllerStore.ChangeIsLyrics', context: context);

  @override
  Future<void> ChangeIsLyrics({required bool val}) {
    return _$ChangeIsLyricsAsyncAction
        .run(() => super.ChangeIsLyrics(val: val));
  }

  @override
  String toString() {
    return '''
fetchPostsFuture: ${fetchPostsFuture},
AllMusic: ${AllMusic},
AllDownloadedMusic: ${AllDownloadedMusic},
currentPosition: ${currentPosition},
totalDuration: ${totalDuration},
isInitialized: ${isInitialized},
isPlaying: ${isPlaying},
isLyrics: ${isLyrics},
isDownloadedPlaying: ${isDownloadedPlaying},
getCurrentMusicIndex: ${getCurrentMusicIndex},
recentPlay: ${recentPlay},
recentMusic: ${recentMusic},
recentDownloadedMusicPlay: ${recentDownloadedMusicPlay},
getAudioHandler: ${getAudioHandler},
getAudioPlayer: ${getAudioPlayer},
getrecentLyrics: ${getrecentLyrics}
    ''';
  }
}
