import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/presentation/lyricsPlayer/lyricsPlayer_screen.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:boilerplate_new_version/widgets/bottom_downloadedMusicPlayer_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:math';

import 'package:sizer/sizer.dart';

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

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    MusicListModule music =
        ModalRoute.of(context)!.settings.arguments as MusicListModule;

    return Observer(
      builder: (context) {
        music = _musicControllerStore.recentMusic;

        return _musicControllerStore.isLyrics
            ? LyricsPlayerScreen()
            : Scaffold(
              body: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xC7DFDDEA),
                  image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    top: 40,
                    right: 8.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: SvgPicture.asset(
                              'assets/svg/playerscreen_back_icon.svg',
                              height: 2.h,
                              width: 2.w,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          Column(
                            children: [
                              Text(
                                "Now Playing From",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black54,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${music.subCategoryName.toString()}",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.more_vert),
                            onPressed: (){},
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 35),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipOval(
                            child: Hero(
                              tag: music.id.toString(),
                              child: FadeInImage(
                                placeholder: AssetImage('assets/icon/icon.png'),
                                image: NetworkImage(music.image.toString()),
                                fit: BoxFit.cover,
                                height: 37.h,
                                width: 83.w,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
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
                                        double tapX = details.localPosition.dx;
                                        double width =
                                            220; // same as your container width

                                        // Calculate tapped percentage
                                        double tappedPercentage = tapX / width;

                                        // Calculate new duration
                                        final newPosition = Duration(
                                          milliseconds:
                                              (tappedPercentage *
                                                      totalDuration
                                                          .inMilliseconds)
                                                  .toInt(),
                                        );

                                        // Seek to the new position using your audio player
                                        _musicControllerStore.seek(newPosition);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.zero,
                                        margin: EdgeInsets.zero,
                                        height: 8.h,
                                        width: 62.w,
                                        child: CustomPaint(
                                          painter: WaveformPainter(
                                            progress:
                                                currentPosition.inMilliseconds /
                                                (totalDuration.inMilliseconds ==
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
                                        () =>
                                            _playPause(music.audio.toString()),
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
//0ld UI---------------------------------------------------------------------------------
// import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
// import 'package:boilerplate_new_version/utils/routes/routes.dart';
// import 'package:boilerplate_new_version/widgets/bottom_downloadedMusicPlayer_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:boilerplate_new_version/di/service_locator.dart';
// import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
// import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';

// class MusicPlayerScreen extends StatefulWidget {
//   MusicPlayerScreen({Key? key}) : super(key: key);

//   @override
//   State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
// }

// class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
//   final MusicControllerStore _musicControllerStore =
//       getIt<MusicControllerStore>();

//   Future<void> _playPause(String musicUrl) async {
//     if (_musicControllerStore.isPlaying) {
//       await _musicControllerStore.pause();
//     } else {
//       await _musicControllerStore.play(musicUrl);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//      MusicListModule music =
//         ModalRoute.of(context)!.settings.arguments as MusicListModule;

//     return Observer(
//       builder: (context) 
//       {
//       music = _musicControllerStore.recentMusic;
//       return Scaffold(
//         appBar: AppBar(
//           title: Observer(
//             builder:
//                 (_) => Text(
//                   music.title ?? 'No Song Playing',
//                   overflow: TextOverflow.ellipsis,
//                 ),
//           ),
//         ),
//         body: Column(
//           children: [
//             Expanded(
//               flex: 6,
//               child: Hero(
//                 tag: music.id.toString(),
//                 child: FadeInImage(
//                   placeholder: AssetImage('assets/icon/icon.png'),
//                   image: NetworkImage(music.image.toString()),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 4,
//               child: Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         IconButton(
//                           icon: Icon(Icons.skip_previous),
//                           color: Colors.white,
//                           iconSize: 40,
//                           onPressed: () async {
//                             _musicControllerStore.seek(Duration.zero);
//                               _musicControllerStore.playPrevious(
//                               currentIndex:  (_musicControllerStore.getCurrentMusicIndex == 0) ? (_musicControllerStore.AllMusic!.length - 1) : _musicControllerStore.getCurrentMusicIndex-1,
//                               previoudPlay:  _musicControllerStore.AllMusic![(_musicControllerStore.getCurrentMusicIndex == 0) ? (_musicControllerStore.AllMusic!.length - 1) : _musicControllerStore.getCurrentMusicIndex-1],
//                               );
//                           },
//                         ),
//                         Container(
//                           height: 80,
//                           width: 80,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.teal.shade700,
//                           ),
//                           child: Observer(
//                             builder:
//                                 (_) => IconButton(
//                                   icon: Icon(
//                                     _musicControllerStore.isPlaying
//                                         ? Icons.pause
//                                         : Icons.play_arrow,
//                                   ),
//                                   color: Colors.white,
//                                   iconSize: 40,
//                                   onPressed:
//                                       () => _playPause(music.audio.toString()),
//                                 ),
//                           ),
//                         ),
//                         Observer(
//                           builder: (context) => IconButton(
//                             icon: Icon(Icons.skip_next),
//                             color: Colors.white,
//                             iconSize: 40,
//                             onPressed: () {
//                               // _musicControllerStore.seek(
//                               //   _musicControllerStore.totalDuration,
//                               // );
//                               _musicControllerStore.playNext(
//                               currentIndex:  (_musicControllerStore.AllMusic!.length-1 == _musicControllerStore.getCurrentMusicIndex) ? 0 : _musicControllerStore.getCurrentMusicIndex+1,
//                               nextplay:  _musicControllerStore.AllMusic![(_musicControllerStore.AllMusic!.length-1 == _musicControllerStore.getCurrentMusicIndex) ? 0 :_musicControllerStore.getCurrentMusicIndex+1],
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Observer(
//                       builder: (_) {
//                         final currentPosition =
//                             _musicControllerStore.currentPosition;
//                         final totalDuration = _musicControllerStore.totalDuration;
      
//                         if (currentPosition ==
//                            totalDuration) {
//                         _musicControllerStore.pause();
//                         }
//                         return Container(
//                           padding: EdgeInsets.all(5),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Text(
//                                 _formatDuration(currentPosition),
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               Expanded(
//                                 child: Slider(
//                                   value: currentPosition.inSeconds.toDouble(),
//                                   max:
//                                       totalDuration.inSeconds > 0
//                                           ? totalDuration.inSeconds.toDouble()
//                                           : 1.0,
//                                   onChanged: (value) async {
//                                     await _musicControllerStore.seek(
//                                       Duration(seconds: value.toInt()),
//                                     );
//                                   },
//                                   activeColor: Colors.orange,
//                                   inactiveColor: Colors.white,
//                                 ),
//                               ),
//                               Text(
//                                 _formatDuration(totalDuration),
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                     IconButton(
//                       onPressed:
//                           () => Navigator.of(context).pushNamed(
//                             Routes.lyricsPlayer,
//                             arguments: _musicControllerStore.getAudioPlayer,
//                           ),
//                       icon: Icon(Icons.lyrics),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//         bottomNavigationBar: Observer(
//         builder: (context) => IntrinsicHeight(
//           child: Column(
//             mainAxisSize:
//                 MainAxisSize.min, // Ensure the column takes only required height
//             children: [
//               _musicControllerStore.isDownloadedPlaying
//                   ? BottomDownloadedMusicPlayerBar(
//                     musicControllerStore: _musicControllerStore,
//                   )
//                   : BottomMusicPlayerBar(
//                     musicControllerStore: _musicControllerStore,
//                   ),
//               // AdsScreen(),
//             ],
//           ),
//         ),
//       ),
//       );
//       } 
//     );
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(duration.inMinutes);
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return '$minutes:$seconds';
//   }
// }
