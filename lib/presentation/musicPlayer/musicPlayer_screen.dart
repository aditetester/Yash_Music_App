import 'package:audio_service/audio_service.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/widgets/musicPlayer_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';

class MusicPlayerScreen extends StatefulWidget {
  MusicPlayerScreen({Key? key}) : super(key: key);

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final MusicControllerStore _musicControllerStore =
      getIt<MusicControllerStore>();

  Future<void> _playPause(String musicUrl) async {
    if (_musicControllerStore.isPlaying) {
      await _musicControllerStore.pause();
    } else {
      await _musicControllerStore.play(musicUrl);
    }
  }

  Future<AudioHandler> initAudioService(MusicListModule music) async {
    return await AudioService.init(
      builder: () => AudioPlayerHandler(music),
      config: AudioServiceConfig(
        androidNotificationChannelId: 'com.example.musicplayer.channel.audio',
        androidNotificationChannelName: 'Music Playback',
        androidNotificationOngoing: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MusicListModule music =
        ModalRoute.of(context)!.settings.arguments as MusicListModule;

    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder:
              (_) => Text(
                music.title ?? 'No Song Playing',
                overflow: TextOverflow.ellipsis,
              ),
        ),
      ),
      body: FutureBuilder<AudioHandler>(
        future: initAudioService(music),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error?.toString()}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Initialization failed.'));
          }

          final audioHandler = snapshot.data!;
          

          return Column(
            children: [
              Expanded(
                flex: 6,
                child: Hero(
                  tag: music.id.toString(),
                  child: FadeInImage(
                    placeholder: AssetImage('assets/icon/icon.png'),
                    image: NetworkImage(music.image.toString()),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.skip_previous),
                            color: Colors.white,
                            iconSize: 40,
                            onPressed:
                                () {}, //_musicControllerStore.playPrevious,
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.teal.shade700,
                            ),
                            child: Observer(
                              builder:
                                  (_) => IconButton(
                                    icon: StreamBuilder<PlaybackState>(
                                      stream: audioHandler.playbackState,
                                      builder: (context, snapshot) {
                                        final playbackState = snapshot.data;
                                        final isPlaying =
                                            playbackState?.playing ?? false;
                                        return Icon(
                                          isPlaying
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                        );
                                      },
                                    ),
                                    color: Colors.white,
                                    iconSize: 40,

                                    onPressed: () async {
                                      final playbackState =
                                          audioHandler.playbackState.value;

                                      if (playbackState.playing) {
                                        await audioHandler.pause();
                                      } else {
                                        await audioHandler.play();
                                      }
                                    },
                                  ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.skip_next),
                            color: Colors.white,
                            iconSize: 40,
                            onPressed:
                                () => _musicControllerStore.playNext(
                                  MusicListModule(),
                                ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Observer(
                        builder: (_) {
                          final currentPosition =
                              _musicControllerStore.currentPosition;
                          final totalDuration =
                              _musicControllerStore.totalDuration;

                          return Container(
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  _formatDuration(currentPosition),
                                  style: TextStyle(color: Colors.white),
                                ),
                                Expanded(
                                  child: Slider(
                                    value: currentPosition.inSeconds.toDouble(),
                                    max:
                                        totalDuration.inSeconds > 0
                                            ? totalDuration.inSeconds.toDouble()
                                            : 1.0,
                                    onChanged: (value) async {
                                      await _musicControllerStore.seek(
                                        Duration(seconds: value.toInt()),
                                      );
                                    },
                                    activeColor: Colors.orange,
                                    inactiveColor: Colors.white,
                                  ),
                                ),
                                Text(
                                  _formatDuration(totalDuration),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: IntrinsicHeight(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BottomMusicPlayerBar(musicControllerStore: _musicControllerStore),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
