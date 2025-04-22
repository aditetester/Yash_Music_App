import 'package:audio_service/audio_service.dart';
import 'package:boilerplate_new_version/data/network/apis/lyricsPlayer/lyricsPlayer_api.dart';
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicModule_list.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/widgets/musicPlayer_handler.dart';
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
  final LyricsApi lyricsApi;

  // AudioPlayer instance
  final AudioPlayer _audioPlayer = AudioPlayer();

  static ObservableFuture<AllMusicList?> emptyMusicListResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<AllMusicList?> fetchPostsFuture =
      ObservableFuture<AllMusicList?>(emptyMusicListResponse);

  @observable
  List<MusicListModule>? AllMusic;
  
  @observable
  List<DownloadedListModule>? AllDownloadedMusic;
  

  // Current Music index
  @observable
  int _currentMusicIndex = 0;
  

  // Current track index
  @observable
  int _currentTrackIndex = 0;


  // Playback state
  @observable
  bool _isPlaying = false;
  
// Playback state
  @observable
  bool _isDownloadedPlaying = false;
  
  // recent play
  @observable
  String _recentPlay = '';

  @observable
  String _recentLyrics = '';

  // recent play
  @observable
  MusicListModule _recentMusic = MusicListModule(
    image: '',
    audio: '',
    title: 'No Play List Available',
  );

   // recent play
  @observable
  DownloadedListModule _recentDownloadedMusicPlay = DownloadedListModule();
   

  @observable
  AudioHandler? _audioHandler;

  @observable
  Duration currentPosition = Duration.zero;

  @observable
  Duration totalDuration = Duration.zero;

  @observable
  bool isInitialized = false;

  // Getters
  @computed
  bool get isPlaying => _isPlaying;
  
  // Getters
  @computed
  bool get isDownloadedPlaying => _isDownloadedPlaying;
  

  // Getters
  @computed
  int get getCurrentMusicIndex => _currentMusicIndex;
  
  // Getters
  @computed
  String get recentPlay => _recentPlay;
  // Getters
  @computed
  MusicListModule get recentMusic => _recentMusic;

  @computed
  DownloadedListModule get recentDownloadedMusicPlay => _recentDownloadedMusicPlay;

  @computed
  AudioHandler? get getAudioHandler => _audioHandler;
  @computed
  AudioPlayer get getAudioPlayer => _audioPlayer;

  @computed
  String get getrecentLyrics => _recentLyrics;

  // String? get currentSongUrl =>
  //     _playlist.isNotEmpty ? _playlist[_currentTrackIndex]['url'] : null;
  // String? get currentSongTitle =>
  //     _playlist.isNotEmpty ? _playlist[_currentTrackIndex]['title'] : null;

  // Constructor

  _MusicControllerStore(this.lyricsApi, this._repository, this.errorStore) {
    init();
    _initialize();
    initAudioService();
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
        changeIsplaying(state.playing);
      });
    });
  }

  // actions:-------------------------------------------------------------------

  @action
  Future<void> initAudioService() async {
    _audioHandler = await AudioService.init(
      builder: () => AudioPlayerHandler(getAudioPlayer),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.example.musicplayer.channel.audio',
        androidNotificationChannelName: 'Music Playback',
        androidNotificationOngoing: true,
      ),
    );
    isInitialized = true;
  }

  @action
  Future<void> lyricsdata() async {
    _recentLyrics = await lyricsApi.getLyrics(_recentMusic.lyrics.toString());
  
  }

  @action
  Future changeIsplaying(bool value) async {
    _isPlaying = value;
    await _repository.changeIsPlaying(value);
  }

  @action
  Future<void> play(String musicUrl) async {
    try {
      if (musicUrl.isNotEmpty) {
        if (_recentPlay == musicUrl) {
          await _audioPlayer.play();
        } else {
          _recentPlay = musicUrl;
          print('Playing: $musicUrl');
          _audioPlayer.setUrl(musicUrl);
          await _audioPlayer.play();
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
  Future<void> playNext({ required int currentIndex, required MusicListModule nextplay}) async {
    _isDownloadedPlaying = false;
    _currentMusicIndex = currentIndex;
    _recentMusic = nextplay;

    print("objectIndex: $_currentMusicIndex");

    lyricsdata();
    await play(nextplay.audio.toString());
  }

  @action
  Future<void> playPrevious({ required int currentIndex, required MusicListModule previoudPlay}) async {
    
    _currentMusicIndex = currentIndex;
    _recentMusic = previoudPlay;
    lyricsdata();
    await play(previoudPlay.audio.toString());
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


  @action
  Future<void> lyricsDownloadeddata() async {
    _recentLyrics = _recentDownloadedMusicPlay.lyrics.toString();
   
  
  }


  @action
  Future<void> playDownloaded(String musicUrl) async {
    try {
      if (musicUrl.isNotEmpty) {
        if (_recentPlay == musicUrl) {
          await _audioPlayer.play();
        } else {
          _recentPlay = musicUrl;
          print('Playing: $musicUrl');
          _audioPlayer.setFilePath(musicUrl);
          await _audioPlayer.play();
        }
      } else {
        print('No song URL available to play');
      }
    } catch (e) {
      print('Error during play: $e');
    }
  }

  @action
  Future<void> playDownloadNext({ required int currentIndex, required DownloadedListModule nextplay}) async {
    _isDownloadedPlaying = true;
    _currentMusicIndex = currentIndex;
    _recentDownloadedMusicPlay = nextplay;
    lyricsDownloadeddata();
    await playDownloaded(nextplay.audio.toString());
  }

  @action
  Future<void> playDownloadPrevious({ required int currentIndex, required DownloadedListModule previoudPlay}) async {
     _isDownloadedPlaying = true;
    _currentMusicIndex = currentIndex;
    _recentDownloadedMusicPlay = previoudPlay;
     lyricsDownloadeddata();
    await playDownloaded(previoudPlay.audio.toString());
  }


  // general methods:-----------------------------------------------------------
  Future init() async {
    _isPlaying = _repository.isPlaying;
  }
}
