import 'package:audioplayers/audioplayers.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/stores/error/error_store.dart';
import '../../../../domain/repository/setting/setting_repository.dart';

part 'music_controller_store.g.dart';

class MusicControllerStore = _MusicControllerStore with _$MusicControllerStore;

abstract class _MusicControllerStore with Store {
  final String TAG = "_MusicControllerStore";

  // Repository instance
  final SettingRepository _repository;

  // Store for handling errors
  final ErrorStore errorStore;

  // AudioPlayer instance
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Playlist
  final ObservableList<Map<String, String>> _playlist = ObservableList.of([
    {'title': 'Song 1', 'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3'},
    {'title': 'Song 2', 'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3'},
    {'title': 'Song 3', 'url': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3'},
  ]);

  // Current track index
  @observable
  int _currentTrackIndex = 0;

  // store variables:-----------------------------------------------------------
  @observable
  bool _isPlaying = false;

  @observable
  Duration currentPosition = Duration.zero;

  @observable
  Duration totalDuration = Duration.zero;

  // getters:-------------------------------------------------------------------
  bool get isPlaying => _isPlaying;
  String? get currentSongUrl => _playlist.isNotEmpty ? _playlist[_currentTrackIndex]['url'] : null;
  String? get currentSongTitle => _playlist.isNotEmpty ? _playlist[_currentTrackIndex]['title'] : null;

  // constructor:---------------------------------------------------------------
  _MusicControllerStore(this._repository, this.errorStore) {
    init();
  }

  // actions:-------------------------------------------------------------------
  @action
  Future<void> changeIsPlaying(bool value) async {
    _isPlaying = value;
    await _repository.changeIsPlaying(value);
  }

  @action
  Future<void> play(String url) async {
    try {
      await _audioPlayer.play(UrlSource(url));
      _isPlaying = true;
    } catch (e) {
      errorStore.errorMessage = "Failed to play audio: $e";
    }
  }

  @action
  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
      _isPlaying = false;
    } catch (e) {
      errorStore.errorMessage = "Failed to pause audio: $e";
    }
  }

  @action
  Future<void> seek(Duration position) async {
    try {
      await _audioPlayer.seek(position);
    } catch (e) {
      errorStore.errorMessage = "Failed to seek audio: $e";
    }
  }

  @action
  Future<void> playNext() async {
    if (_currentTrackIndex < _playlist.length - 1) {
      _currentTrackIndex++;
      await play(currentSongUrl!);
    } else {
      errorStore.errorMessage = "No next track available.";
    }
  }

  @action
  Future<void> playPrevious() async {
    if (_currentTrackIndex > 0) {
      _currentTrackIndex--;
      await play(currentSongUrl!);
    } else {
      errorStore.errorMessage = "No previous track available.";
    }
  }

  @action
  void addToPlaylist(String title, String url) {
    _playlist.add({'title': title, 'url': url});
  }

  @action
  void removeFromPlaylist(int index) {
    if (index >= 0 && index < _playlist.length) {
      _playlist.removeAt(index);
    }
  }

  // general methods:-----------------------------------------------------------
  Future<void> init() async {
    _isPlaying = _repository.isPlaying;

    // Listen to position changes
    _audioPlayer.onPositionChanged.listen((position) {
      currentPosition = position;
    });

    // Listen to duration changes
    _audioPlayer.onDurationChanged.listen((duration) {
      totalDuration = duration;
    });

    // Handle playback completion
    _audioPlayer.onPlayerComplete.listen((_) async {
      _isPlaying = false;
      await playNext(); // Automatically play the next track on completion
    });
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
