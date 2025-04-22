import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:boilerplate_new_version/widgets/bottom_downloadedMusicPlayer_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';

class MusicPlayerDownloadedScreen extends StatefulWidget {
  MusicPlayerDownloadedScreen({Key? key}) : super(key: key);

  @override
  State<MusicPlayerDownloadedScreen> createState() => _MusicPlayerDownloadedScreenState();
}

class _MusicPlayerDownloadedScreenState extends State<MusicPlayerDownloadedScreen> {
  final MusicControllerStore _musicControllerStore =
      getIt<MusicControllerStore>();

  Future<void> _playPause(String musicUrl) async {
    if (_musicControllerStore.isPlaying) {
      await _musicControllerStore.pause();
    } else {
      await _musicControllerStore.play(musicUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
     DownloadedListModule music =
        ModalRoute.of(context)!.settings.arguments as DownloadedListModule;

    return Observer(
      builder: (context) 
      {
      music = _musicControllerStore.recentDownloadedMusicPlay;
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
        body: Column(
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
                          onPressed: () async {
                            _musicControllerStore.seek(Duration.zero);
                              _musicControllerStore.playDownloadPrevious(
                              currentIndex:  (_musicControllerStore.getCurrentMusicIndex == 0) ? (_musicControllerStore.AllDownloadedMusic!.length - 1) : _musicControllerStore.getCurrentMusicIndex-1,
                              previoudPlay:  _musicControllerStore.AllDownloadedMusic![(_musicControllerStore.getCurrentMusicIndex == 0) ? (_musicControllerStore.AllDownloadedMusic!.length - 1) : _musicControllerStore.getCurrentMusicIndex-1],
                              );
                          },
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
                                  icon: Icon(
                                    _musicControllerStore.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                  ),
                                  color: Colors.white,
                                  iconSize: 40,
                                  onPressed:
                                      () => _playPause(music.audio.toString()),
                                ),
                          ),
                        ),
                        Observer(
                          builder: (context) => IconButton(
                            icon: Icon(Icons.skip_next),
                            color: Colors.white,
                            iconSize: 40,
                            onPressed: () {
                              // _musicControllerStore.seek(
                              //   _musicControllerStore.totalDuration,
                              // );
                              _musicControllerStore.playDownloadNext(
                              currentIndex:  (_musicControllerStore.AllDownloadedMusic!.length-1 == _musicControllerStore.getCurrentMusicIndex) ? 0 : _musicControllerStore.getCurrentMusicIndex+1,
                              nextplay:  _musicControllerStore.AllDownloadedMusic![(_musicControllerStore.AllDownloadedMusic!.length-1 == _musicControllerStore.getCurrentMusicIndex) ? 0 :_musicControllerStore.getCurrentMusicIndex+1],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Observer(
                      builder: (_) {
                        final currentPosition =
                            _musicControllerStore.currentPosition;
                        final totalDuration = _musicControllerStore.totalDuration;
      
                        if (currentPosition ==
                           totalDuration) {
                        _musicControllerStore.pause();
                        }
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
                    IconButton(
                      onPressed:
                          () => Navigator.of(context).pushNamed(
                            Routes.lyricsPlayer,
                            arguments: _musicControllerStore.getAudioPlayer,
                          ),
                      icon: Icon(Icons.lyrics),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
         bottomNavigationBar: Observer(
        builder: (context) => IntrinsicHeight(
          child: Column(
            mainAxisSize:
                MainAxisSize.min, // Ensure the column takes only required height
            children: [
              _musicControllerStore.isDownloadedPlaying
                  ? BottomDownloadedMusicPlayerBar(
                    musicControllerStore: _musicControllerStore,
                  )
                  : BottomMusicPlayerBar(
                    musicControllerStore: _musicControllerStore,
                  ),
              // AdsScreen(),
            ],
          ),
        ),
      ),
      );
      } 
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
