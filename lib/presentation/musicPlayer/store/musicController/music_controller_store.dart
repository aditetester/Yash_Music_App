import 'package:audio_service/audio_service.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';
import 'package:boilerplate_new_version/domain/usecase/music_list/get_musicList_usecase.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/widgets/musicPlayer_handler.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/stores/error/error_store.dart';
import '../../../../domain/repository/setting/setting_repository.dart';

part 'music_controller_store.g.dart';

class MusicControllerStore = _MusicControllerStore with _$MusicControllerStore;

abstract class _MusicControllerStore with Store {
  final String TAG = "_MusicControllerStore";

  final GetMusiclistUsecase _getMusicListUseCase;
  final SettingRepository _repository;
  final ErrorStore errorStore;

  // AudioPlayer instance
  final AudioPlayer _audioPlayer = AudioPlayer();

  static ObservableFuture<AllMusicList?> emptyMusicListResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<AllMusicList?> fetchPostsFuture =
      ObservableFuture<AllMusicList?>(emptyMusicListResponse);

  @observable
  List<MusicListModule>? AllMusic;

  final AudioHandler _audioHandler = MyAudioHandler();

  // Current track index
  @observable
  int _currentTrackIndex = 0;

  // Playback state
  @observable
  bool _isPlaying = false;

  // Getters
  bool get isPlaying => _isPlaying;
  // recent play
  @observable
  String _recentPlay = '';

  // Getters
  String get recentPlay => _recentPlay;

  // recent play
  @observable
  MusicListModule _recentMusic = MusicListModule(
    image: '',
    audio: '',
    title: 'Not Played Recently',
  );

  // Getters
  MusicListModule get recentMusic => _recentMusic;

  @observable
  Duration currentPosition = Duration.zero;

  @observable
  Duration totalDuration = Duration.zero;

  // String? get currentSongUrl =>
  //     _playlist.isNotEmpty ? _playlist[_currentTrackIndex]['url'] : null;
  // String? get currentSongTitle =>
  //     _playlist.isNotEmpty ? _playlist[_currentTrackIndex]['title'] : null;

  // Constructor
  _MusicControllerStore(
    this._getMusicListUseCase,
    this._repository,
    this.errorStore,
  ) {
    init();
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
        // _isPlaying = state.playing;
        changeIsplaying(state.playing);
      });
    });
    _audioHandler.playbackState.listen((state) {
      runInAction(() {
        _isPlaying = state.playing;
        currentPosition = state.updatePosition;
      });
    });
  }

  // actions:-------------------------------------------------------------------
  @action
  Future changeIsplaying(bool value) async {
    _isPlaying = value;
    await _repository.changeIsPlaying(value);
  }

  @action
  Future<void> play(String musicUrl) async {
    try {
      if (musicUrl.isNotEmpty) {
        if (_recentPlay == musicUrl && _audioPlayer.playing == false) {
          // Resume playback if the same track is already loaded
          await _audioPlayer.play();
        }
         else {
          await _audioHandler.addQueueItem(
            MediaItem(
              id: musicUrl,
              title: _recentMusic.title.toString(),
              artist: _recentMusic.subtitle.toString(),
            ),
          );
          // Load new track and play
          _recentPlay = musicUrl;
          print('Playing: $musicUrl');
          await _audioPlayer.setUrl(musicUrl); // Set the audio URL
          await _audioPlayer.play(); // Start playback
        }
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
  Future<void> playNext(MusicListModule nextplay) async {
    _recentMusic = nextplay;
    await play(nextplay.audio.toString());
  }

  @action
  Future<void> playPrevious() async {
    // if (_currentTrackIndex > 0) {
    //   _currentTrackIndex--;
    await play('');
    // }
  }

  @action
  Future<void> seek(Duration position) async {
    try {
      await _audioPlayer.seek(position);
    } catch (e) {
      print('Error during seek: $e');
    }
  }

  void dispose() async {
    await _audioPlayer.dispose();
  }

  // general methods:-----------------------------------------------------------
  Future init() async {
    _isPlaying = _repository.isPlaying;
  }
}
