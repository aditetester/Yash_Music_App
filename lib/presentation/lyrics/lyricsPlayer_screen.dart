import 'package:boilerplate_new_version/widgets/bottom_downloadedMusicPlayer_bar.dart';
import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/lyrics/lyricsModule.dart';
import 'package:boilerplate_new_version/presentation/music_player/store/musicController/music_controller_store.dart';
import 'package:sizer/sizer.dart';

class LyricsPlayerScreen extends StatefulWidget {
  const LyricsPlayerScreen({Key? key}) : super(key: key);

  @override
  State<LyricsPlayerScreen> createState() => _LyricsPlayerScreenState();
}

class _LyricsPlayerScreenState extends State<LyricsPlayerScreen> {
  final ScrollController _scrollController = ScrollController();
  final MusicControllerStore _musicControllerStore =
      getIt<MusicControllerStore>();

  List<LyricsPlayerModule> lyrics = [];
  String? lrcData;
  int currentIndex = 0;
  bool userScrolling = false;

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  Future<void> _playPause(String musicUrl) async {
    if (_musicControllerStore.isPlaying) {
      await _musicControllerStore.pause();
    } else {
      await _musicControllerStore.play(musicUrl);
    }
  }

  @override
  void initState() {
    super.initState();
    String lrcData = _musicControllerStore.getrecentLyrics;
    lyrics = parseLRC(lrcData);

    _scrollController.addListener(() {
      if (_scrollController.position.isScrollingNotifier.value) {
        userScrolling = true;
      }
    });
  }

  List<LyricsPlayerModule> parseLRC(String lrc) {
    final regex = RegExp(r"\[(\d+):(\d+\.\d+)\](.*)");
    List<LyricsPlayerModule> parsedLyrics = [];

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
        parsedLyrics.add(LyricsPlayerModule(time, text));
      }
    }
    return parsedLyrics;
  }

  void scrollToCenter() {
    if (_scrollController.hasClients) {
      final itemHeight = 50.0; // Approx height of each lyric line
      final screenHeight = MediaQuery.of(context).size.height;
      final centerOffset =
          (currentIndex * itemHeight) - (screenHeight / 2) + (itemHeight / 2);

      _scrollController.animateTo(
        centerOffset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void seekToLyric(AudioPlayer player, int index) {
    if (index >= 0 && index < lyrics.length) {
      player.seek(lyrics[index].time);
      //scrollToCenter(); // Don't scroll immediately on seek
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final _audioPlayer = _musicControllerStore.getAudioPlayer;
        final music = _musicControllerStore.recentMusic;
        lrcData = _musicControllerStore.getrecentLyrics;
        lyrics = parseLRC(lrcData!);
        return Scaffold(
          body: Stack(
            children: [
              Container(
                height: 75.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      _musicControllerStore.recentMusic.image.toString(),
                    ),
                    fit: BoxFit.cover,

                  ),
                ),
              ),

              Container(
                height: 75.h,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(0, 255, 255, 255), // 60% transparent white
                    Color.fromARGB(255, 215, 194, 210),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(
                        153,
                        255,
                        255,
                        255,
                      ), // 60% transparent white
                      Color.fromARGB(255, 215, 194, 210),
                    ],
                  ),
                ),
              ),
            
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Container(
                  height: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      top: 40,
                      right: 8.0,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [ IconButton(icon: Icon(Icons.more_vert, color: Colors.black,), onPressed: (){}),],),
                        ),
                        Container(
                          height: 45.h,
                          child: Expanded(
                            child: Observer(
                              builder: (context) {
                                final position =
                                    _musicControllerStore.currentPosition;
                                int newIndex = lyrics.lastIndexWhere(
                                  (lyric) => lyric.time <= position,
                                );
                                if (newIndex != currentIndex &&
                                    newIndex != -1) {
                                  currentIndex = newIndex;
                                  WidgetsBinding.instance.addPostFrameCallback((
                                    _,
                                  ) {
                                    scrollToCenter();
                                  });
                                }

                                return ListView.builder(
                                  controller: _scrollController,
                                  itemCount: lyrics.length,
                                  itemBuilder: (context, index) {
                                    final isActive = index == currentIndex;
                                    return GestureDetector(
                                      onTap:
                                          () =>
                                              seekToLyric(_audioPlayer, index),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                          horizontal: 20.0,
                                        ),
                                        child: Text(
                                          lyrics[index].text,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: isActive ? 18 : 14,
                                            fontWeight:
                                                isActive
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                            color:
                                                isActive
                                                    ? Colors.black
                                                    : Color.fromARGB(
                                                      255,
                                                      96,
                                                      96,
                                                      96,
                                                    ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 37),
                        Container(
                          width: 40.h,
                          child: Center(
                            child: Text(
                              music.title ?? 'No Song Playing',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Text(
                          music.subtitle ?? '',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        SizedBox(height: 20),
                        Observer(
                          builder: (_) {
                            var currentPosition =
                                _musicControllerStore.currentPosition;
                            var totalDuration =
                                _musicControllerStore.totalDuration;

                            if (_formatDuration(currentPosition) ==
                                _formatDuration(totalDuration)) {
                              _musicControllerStore.pause();
                            }
                            return Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 13.w,
                                        child: Text(
                                          _formatDuration(currentPosition),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTapDown: (TapDownDetails details) {
                                          // Get tap position
                                          double tapX =
                                              details.localPosition.dx;
                                          double width =
                                              220; // same as your container width

                                          // Calculate tapped percentage
                                          double tappedPercentage =
                                              tapX / width;

                                          // Calculate new duration
                                          final newPosition = Duration(
                                            milliseconds:
                                                (tappedPercentage *
                                                        totalDuration
                                                            .inMilliseconds)
                                                    .toInt(),
                                          );

                                          // Seek to the new position using your audio player
                                          _musicControllerStore.seek(
                                            newPosition,
                                          );
                                        },
                                        child: Container(
                                          padding: EdgeInsets.zero,
                                          margin: EdgeInsets.zero,
                                          height: 8.h,
                                          width: 62.w,
                                          child: CustomPaint(
                                            painter: WaveformPainter(
                                              progress:
                                                  currentPosition
                                                      .inMilliseconds /
                                                  (totalDuration
                                                              .inMilliseconds ==
                                                          0
                                                      ? 1
                                                      : totalDuration
                                                          .inMilliseconds),
                                            ),
                                            child: Container(),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        width: 13.w,
                                        child: Text(
                                          _formatDuration(totalDuration),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  "assets/svg/shuffle_icon.svg",
                                  height: 20,
                                  width: 20,
                                ),
                                onPressed: null,
                              ),
                            ),
                            IconButton(
                              icon: SvgPicture.asset(
                                "assets/svg/playprevious_icon.svg",
                                height: 40,
                                width: 40,
                              ),
                              onPressed: () async {
                                _musicControllerStore.seek(Duration.zero);
                                _musicControllerStore.playPrevious(
                                  currentIndex:
                                      (_musicControllerStore
                                                  .getCurrentMusicIndex ==
                                              0)
                                          ? (_musicControllerStore
                                                  .AllMusic!
                                                  .length -
                                              1)
                                          : _musicControllerStore
                                                  .getCurrentMusicIndex -
                                              1,
                                  previoudPlay:
                                      _musicControllerStore
                                          .AllMusic![(_musicControllerStore
                                                  .getCurrentMusicIndex ==
                                              0)
                                          ? (_musicControllerStore
                                                  .AllMusic!
                                                  .length -
                                              1)
                                          : _musicControllerStore
                                                  .getCurrentMusicIndex -
                                              1],
                                );
                              },
                            ),
                            Container(
                              height: 7.h,
                              width: 15.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 29, 162, 244),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(
                                      0.3,
                                    ), // shadow color
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    offset: Offset(
                                      0,
                                      0,
                                    ), // shadow position (x, y)
                                  ),
                                ],
                              ),
                              child: Observer(
                                builder:
                                    (_) => IconButton(
                                      icon:
                                          _musicControllerStore.isPlaying
                                              ? SvgPicture.asset(
                                                'assets/svg/pause_icon.svg',
                                                height: 35,
                                                width: 35,
                                              )
                                              : Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 4.0,
                                                ),
                                                child: SvgPicture.asset(
                                                  'assets/svg/play_icon.svg',
                                                  height: 50,
                                                  width: 50,
                                                ),
                                              ),

                                      color: Colors.white,
                                      iconSize: 40,
                                      onPressed:
                                          () => _playPause(
                                            music.audio.toString(),
                                          ),
                                    ),
                              ),
                            ),
                            IconButton(
                              icon: SvgPicture.asset(
                                "assets/svg/playnext_icon.svg",
                                height: 40,
                                width: 40,
                              ),
                              onPressed: () {
                                _musicControllerStore.playNext(
                                  currentIndex:
                                      (_musicControllerStore.AllMusic!.length -
                                                  1 ==
                                              _musicControllerStore
                                                  .getCurrentMusicIndex)
                                          ? 0
                                          : _musicControllerStore
                                                  .getCurrentMusicIndex +
                                              1,
                                  nextplay:
                                      _musicControllerStore
                                          .AllMusic![(_musicControllerStore
                                                      .AllMusic!
                                                      .length -
                                                  1 ==
                                              _musicControllerStore
                                                  .getCurrentMusicIndex)
                                          ? 0
                                          : _musicControllerStore
                                                  .getCurrentMusicIndex +
                                              1],
                                );
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: IconButton(
                                icon: SvgPicture.asset(
                                  "assets/svg/repeat_icon.svg",
                                  height: 20,
                                  width: 20,
                                ),
                                onPressed: null,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: Observer(
            builder:
                (context) => IntrinsicHeight(
                  child: Column(
                    mainAxisSize:
                        MainAxisSize
                            .min, // Ensure the column takes only required height
                    children: [
                      _musicControllerStore.isDownloadedPlaying
                          ? BottomDownloadedMusicPlayerBar(
                            musicControllerStore: _musicControllerStore,
                            isTapEnable: false,
                          )
                          : BottomMusicPlayerBar(
                            musicControllerStore: _musicControllerStore,
                            isTapEnable: false,
                          ),
                      // AdsScreen(),
                    ],
                  ),
                ),
          ),
        );
      },
    );
  }
}

class WaveformPainter extends CustomPainter {
  final double progress;

  WaveformPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..strokeWidth = 3.0
          ..strokeCap = StrokeCap.round;

    // Define the repeating pattern of bar heights
    // Each number represents the relative height of a bar
    final pattern = [
      0.1,
      0.1,
      0.3,
      0.2,
      0.1,
      0.3,
      0.5,
      0.8,
      0.4,
      0.2,
      0.4,
      0.8,
      0.4,
      0.2,
      0.3,
      0.6,
      0.5,
      0.7,
      0.4,
      0.2,
    ];
    final patternLength = pattern.length;

    final barCount = 42; // Total number of bars to draw
    final space = size.width / (barCount + 0.5);
    final baseHeight = size.height / 2;

    for (int i = 0; i < barCount; i++) {
      // Get height from the pattern, repeating as needed
      final patternIndex = i % patternLength;
      final heightFactor = pattern[patternIndex];
      final height =
          heightFactor * size.height * 0.8; // Scale to 80% of full height

      // Color based on progress
      paint.color =
          (i / barCount) < progress
              ? Colors.blue
              : const Color.fromARGB(255, 0, 0, 0);

      canvas.drawLine(
        Offset((i + 1) * space, baseHeight - height / 2),
        Offset((i + 1) * space, baseHeight + height / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant WaveformPainter oldDelegate) =>
      oldDelegate.progress != progress;
}



// import 'package:boilerplate_new_version/di/service_locator.dart';
// import 'package:boilerplate_new_version/domain/entity/lyricsPlayer/lyricsModule.dart';
// import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:just_audio/just_audio.dart';

// class LyricsPlayerScreen extends StatefulWidget {

//   const LyricsPlayerScreen({super.key});

//   @override
//   State<LyricsPlayerScreen> createState() => _LyricsPlayerScreenState();
// }

// class _LyricsPlayerScreenState extends State<LyricsPlayerScreen> {
//   final ScrollController _scrollController = ScrollController();
//   final MusicControllerStore _musicControllerStore =
//       getIt<MusicControllerStore>();

//   List<LyricsPlayerModule> lyrics = [];
//   int currentIndex = 0;
//   String lrcData = "";
//   @override
//   void initState() {
//     super.initState();
    
//     lrcData =  _musicControllerStore.getrecentLyrics;
//     print(lrcData);

//     lyrics = parseLRC(lrcData);
  
//   }

//   List<LyricsPlayerModule> parseLRC(String lrc) {
//     final regex = RegExp(r"\[(\d+):(\d+\.\d+)\](.*)");
//     List<LyricsPlayerModule> lyrics = [];

//     for (var line in lrc.split("\n")) {
//       final match = regex.firstMatch(line);
//       if (match != null) {
//         final minutes = int.parse(match.group(1)!);
//         final seconds = double.parse(match.group(2)!);
//         final text = match.group(3)!.trim();

//         final time = Duration(
//           minutes: minutes,
//           seconds: seconds.toInt(),
//           milliseconds: ((seconds % 1) * 1000).toInt(),
//         );
//         lyrics.add(LyricsPlayerModule(time, text));
//       }
//     }

//     return lyrics;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final _audioPlayer =
//         ModalRoute.of(context)!.settings.arguments as AudioPlayer;

//     void _scrollToCurrentLyric() {
    
//     if (currentIndex == -1  || _scrollController.hasClients == false) return;

//   // Define how many lines before stopping auto-scroll
//   int stopScrollingThreshold = 6;
  
//   if (currentIndex >= lyrics.length - stopScrollingThreshold) {
//     return; // Stop auto-scrolling if near the end
//   }

//   // Scroll to the selected lyric
//   _scrollController.animateTo(
//     currentIndex * 30.0, // Adjust 40.0 based on text size
//     duration: Duration(milliseconds: 300),
//     curve: Curves.easeInOut,
//   );
// }
//     void _seekToLyric(int index) {
//       if (index >= 0 && index < lyrics.length) {
//         _audioPlayer.seek(lyrics[index].time);
//         _scrollToCurrentLyric();
//       }
//     }


//     return Scaffold(
//       appBar: AppBar(title: Text("Lyrics Player")),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               // controller: _scrollController,
//               itemCount: lyrics.length,
//               itemBuilder: (context, index) {
//                  _scrollToCurrentLyric();
//                 return GestureDetector(
//                   onTap: () => _seekToLyric(index),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 5,
//                       horizontal: 20,
//                     ),
//                     child: Observer(
//                       builder: (context) {
//                         // _scrollToCurrentLyric();
//                         final currentPosition =
//                             _musicControllerStore.currentPosition;
//                         int newIndex = lyrics.lastIndexWhere(
//                           (lyric) => lyric.time <= currentPosition,
//                         );
//                         currentIndex = newIndex;
//                         return Text(
//                           lyrics[index].text,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight:
//                                 index == currentIndex
//                                     ? FontWeight.bold
//                                     : FontWeight.normal,
//                             color:
//                                 index == currentIndex
//                                     ? Colors.blue
//                                     : Colors.white,
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
// }
