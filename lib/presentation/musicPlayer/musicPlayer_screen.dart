import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';

class MusicPlayerScreen extends StatelessWidget {
  final MusicControllerStore _musicControllerStore =
      getIt<MusicControllerStore>();

  MusicPlayerScreen({Key? key}) : super(key: key);

  Future<void> _playPause() async {
    if (_musicControllerStore.isPlaying) {
      await _musicControllerStore.pause();
    } else {
      await _musicControllerStore.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Observer(
          builder: (_) => Text(
            _musicControllerStore.currentSongTitle ?? 'No Song Playing',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icon/icon.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              color: Colors.teal.shade800,
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
                        onPressed: _musicControllerStore.playPrevious,
                      ),
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.teal.shade700,
                        ),
                        child: Observer(
                          builder: (_) => IconButton(
                            icon: Icon(
                              _musicControllerStore.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                            ),
                            color: Colors.white,
                            iconSize: 40,
                            onPressed: _playPause,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_next),
                        color: Colors.white,
                        iconSize: 40,
                        onPressed: _musicControllerStore.playNext,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Observer(
                    builder: (_) {
                      final currentPosition = _musicControllerStore.currentPosition;
                      final totalDuration = _musicControllerStore.totalDuration;

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            _formatDuration(currentPosition),
                            style: TextStyle(color: Colors.white),
                          ),
                          Expanded(
                            child: Slider(
                              value: currentPosition.inSeconds.toDouble(),
                              max: totalDuration.inSeconds.toDouble(),
                              onChanged: (value) {
                                _musicControllerStore.seek(
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
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
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
