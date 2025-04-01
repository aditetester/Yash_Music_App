
import 'package:boilerplate_new_version/data/network/apis/lyricsPlayer/LyricsPlayer_api.dart';
import 'package:boilerplate_new_version/data/network/apis/lyricsPlayer/lyricsPlayer_api.dart';
import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/lyricsPlayer/lyricsModule.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:just_audio/just_audio.dart';

class LyricsPlayerScreen extends StatefulWidget {

  const LyricsPlayerScreen({super.key});

  @override
  State<LyricsPlayerScreen> createState() => _LyricsPlayerScreenState();
}

class _LyricsPlayerScreenState extends State<LyricsPlayerScreen> {
  final ScrollController _scrollController = ScrollController();
  final MusicControllerStore _musicControllerStore =
      getIt<MusicControllerStore>();

  List<LyricsPlayerModule> lyrics = [];
  int currentIndex = 0;
  String lrcData = "";
  @override
  void initState() {
    super.initState();
    
    lrcData =  _musicControllerStore.getrecentLyrics;
    print(lrcData);

    lyrics = parseLRC(lrcData);
  
  }

  List<LyricsPlayerModule> parseLRC(String lrc) {
    final regex = RegExp(r"\[(\d+):(\d+\.\d+)\](.*)");
    List<LyricsPlayerModule> lyrics = [];

    for (var line in lrc.split("\n")) {
      final match = regex.firstMatch(line);
      if (match != null) {
        final minutes = int.parse(match.group(1)!);
        final seconds = double.parse(match.group(2)!);
        final text = match.group(3)!.trim();

        final time = Duration(
          minutes: minutes,
          seconds: seconds.toInt(),
          milliseconds: ((seconds % 1) * 1000).toInt(),
        );
        lyrics.add(LyricsPlayerModule(time, text));
      }
    }

    return lyrics;
  }

  @override
  Widget build(BuildContext context) {
    final _audioPlayer =
        ModalRoute.of(context)!.settings.arguments as AudioPlayer;

    void _scrollToCurrentLyric() {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          currentIndex * 20.0,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
    void _seekToLyric(int index) {
      if (index >= 0 && index < lyrics.length) {
        _audioPlayer.seek(lyrics[index].time);
        _scrollToCurrentLyric();
      }
    }


    return Scaffold(
      appBar: AppBar(title: Text("Lyrics Player")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: lyrics.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _seekToLyric(index),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Observer(
                      builder: (context) {
                        _scrollToCurrentLyric();
                        final currentPosition =
                            _musicControllerStore.currentPosition;
                        int newIndex = lyrics.lastIndexWhere(
                          (lyric) => lyric.time <= currentPosition,
                        );
                        currentIndex = newIndex;
                        return Text(
                          lyrics[index].text,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight:
                                index == currentIndex
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color:
                                index == currentIndex
                                    ? Colors.blue
                                    : Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
