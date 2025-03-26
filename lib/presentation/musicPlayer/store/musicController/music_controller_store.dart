import 'package:audio_service/audio_service.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/widgets/musicPlayer_Handler.dart';
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
  late final AudioHandler _audioHandler;

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
  String? get currentSongUrl => _playlist.isNotEmpty ? _playlist[_currentTrackIndex]['url'] : null;
  String? get currentSongTitle => _playlist.isNotEmpty ? _playlist[_currentTrackIndex]['title'] : null;

  // Constructor
  _MusicControllerStore(this._repository, this.errorStore) {
    _initAudioHandler();
    _observeAudioPlayer();
  }

  Future<void> _initAudioHandler() async {
    try {
      final mediaItems = _playlist.map((track) {
        return MediaItem(
          id: track['url']!,
          title: track['title']!,
          artist: 'Unknown Artist',
        );
      }).toList();

      _audioHandler = await AudioService.init(
        builder: () => AudioPlayerHandler(_audioPlayer, mediaItems),
        config: const AudioServiceConfig(
          androidNotificationChannelId: 'com.example.music.channel.audio',
          androidNotificationChannelName: 'Music Playback',
          androidNotificationOngoing: true,
        ),
      );

      print('AudioHandler initialized successfully');
    } catch (e) {
      print('Error initializing AudioHandler: $e');
    }
  }

  void _observeAudioPlayer() {
    _audioPlayer.positionStream.listen((position) {
      currentPosition = position;
    });
    _audioPlayer.durationStream.listen((duration) {
      totalDuration = duration ?? Duration.zero;
    });
    _audioPlayer.playingStream.listen((isPlaying) {
      _isPlaying = isPlaying;
    });
  }

  // Actions
  @action
  Future<void> play() async {
    try {
      if (_audioHandler == null) {
        await _initAudioHandler();
      }
      if (currentSongUrl != null) {
        print('Attempting to play: $currentSongUrl');
        await _audioHandler.playMediaItem(
          MediaItem(id: currentSongUrl!, title: currentSongTitle ?? 'Unknown'),
        );
        _isPlaying = true;
      } else {
        print('No song URL available to play');
      }
    } catch (e) {
      print('Error during play: $e');
    }
  }

  @action
  Future<void> pause() async {
    await _audioHandler.pause();
    _isPlaying = false;
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
    await _audioHandler.seek(position);
  }

  void dispose() {
    _audioHandler.stop();
  }
}
