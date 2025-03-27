import 'package:just_audio/just_audio.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/stores/error/error_store.dart';
import '../../../../domain/repository/setting/setting_repository.dart';

part 'music_controller_store.g.dart';

class MusicControllerStore = _MusicControllerStore with _$MusicControllerStore;

abstract class _MusicControllerStore with Store {
  final String TAG = "_MusicControllerStore";

  final SettingRepository _repository;
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

  // Playback state
  @observable
  bool _isPlaying = false;

  @observable
  Duration currentPosition = Duration.zero;

  @observable
  Duration totalDuration = Duration.zero;

  // Getters
  bool get isPlaying => _isPlaying;
  String? get currentSongUrl =>
      _playlist.isNotEmpty ? _playlist[_currentTrackIndex]['url'] : null;
  String? get currentSongTitle =>
      _playlist.isNotEmpty ? _playlist[_currentTrackIndex]['title'] : null;

  // Constructor
  _MusicControllerStore(this._repository, this.errorStore) {
    _initialize();
  }

  Future<void> _initialize() async {
    _observeAudioPlayer();
  }

  void _observeAudioPlayer() {
    _audioPlayer.positionStream.listen((position) {
      runInAction(() {
        currentPosition = position;
      });
    });

    _audioPlayer.durationStream.listen((duration) {
      runInAction(() {
        totalDuration = duration ?? Duration.zero;
      });
    });

    _audioPlayer.playerStateStream.listen((state) {
      runInAction(() {
        _isPlaying = state.playing;
      });
    });
  }

  @action
  Future<void> play() async {
    try {
      if (currentSongUrl != null) {
        print('Playing: $currentSongUrl');
        await _audioPlayer.setUrl(currentSongUrl!); // Set the audio URL
        await _audioPlayer.play(); // Start playback
      } else {
        print('No song URL available to play');
      }
    } catch (e) {
      print('Error during play: $e');
    }
  }

  @action
  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
    } catch (e) {
      print('Error during pause: $e');
    }
  }

  @action
  Future<void> playNext() async {
    if (_currentTrackIndex < _playlist.length - 1) {
      _currentTrackIndex++;
      await play();
    }
  }

  @action
  Future<void> playPrevious() async {
    if (_currentTrackIndex > 0) {
      _currentTrackIndex--;
      await play();
    }
  }

  @action
  Future<void> seek(Duration position) async {
    try {
      await _audioPlayer.seek(position);
    } catch (e) {
      print('Error during seek: $e');
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
