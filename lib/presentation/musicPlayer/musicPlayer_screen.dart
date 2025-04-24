// import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
// import 'package:boilerplate_new_version/utils/routes/routes.dart';
// import 'package:boilerplate_new_version/widgets/bottom_downloadedMusicPlayer_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_mobx/flutter_mobx.dart';
// import 'package:boilerplate_new_version/di/service_locator.dart';
// import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
// import 'package:boilerplate_new_version/widgets/bottom_musicPlayer_bar.dart';
// import 'dart:math';

// import 'package:sizer/sizer.dart';

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
//     MusicListModule music =
//         ModalRoute.of(context)!.settings.arguments as MusicListModule;

//     return Observer(
//       builder: (context) {
//         music = _musicControllerStore.recentMusic;
//         return Scaffold(
//           body: Container(
//             height: double.infinity,
//             decoration: BoxDecoration(
//               color: Color(0xC7DFDDEA),
//               image: DecorationImage(
//                 image: AssetImage("assets/images/background.png"),
//                 fit: BoxFit.cover,
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 8.0, top: 40, right: 8.0),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                         icon: Icon(Icons.keyboard_arrow_down),
//                         onPressed: null,
//                       ),
//                       Column(
//                         children: [
//                           Text(
//                             "Now Playing From",
//                             style: TextStyle(
//                               color: Colors.black54,
//                               fontSize: 12,
//                             ),
//                           ),
//                           Text(
//                             "Power of Attitude",
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ],
//                       ),
//                       IconButton(icon: Icon(Icons.more_vert), onPressed: null),
//                     ],
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: 40),
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(color: Colors.black, width: 3),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: ClipOval(
//                         child: Hero(
//                           tag: music.id.toString(),
//                           child: FadeInImage(
//                             placeholder: AssetImage('assets/icon/icon.png'),
//                             image: NetworkImage(music.image.toString()),
//                             fit: BoxFit.cover,
//                             height: 300,
//                             width: 300,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 30),
//                   Container(
//                     width: 40.h,
//                     child: Center(
//                       child: Text(
//                         music.title ?? 'No Song Playing',
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ),
//                   Text(
//                     music.subtitle ?? '',
//                     style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
//                   ),
//                   Spacer(),
//                   Observer(
//                     builder: (_) {
//                       final currentPosition =
//                           _musicControllerStore.currentPosition;
//                       final totalDuration = _musicControllerStore.totalDuration;

//                       if (currentPosition == totalDuration) {
//                         _musicControllerStore.pause();
//                       }

//                       return Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0,
//                             ),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(_formatDuration(currentPosition)),
//                                 GestureDetector(
//                                   onTapDown: (TapDownDetails details) {
//                                     // Get tap position
//                                     double tapX = details.localPosition.dx;
//                                     double width =
//                                         220; // same as your container width

//                                     // Calculate tapped percentage
//                                     double tappedPercentage = tapX / width;

//                                     // Calculate new duration
//                                     final newPosition = Duration(
//                                       milliseconds:
//                                           (tappedPercentage *
//                                                   totalDuration.inMilliseconds)
//                                               .toInt(),
//                                     );

//                                     // Seek to the new position using your audio player
//                                     _musicControllerStore.seek(newPosition);
//                                   },
//                                   child: Container(
//                                     height: 50,
//                                     width: 220,
//                                     child: CustomPaint(
//                                       painter: WaveformPainter(
//                                         progress:
//                                             currentPosition.inMilliseconds /
//                                             (totalDuration.inMilliseconds == 0
//                                                 ? 1
//                                                 : totalDuration.inMilliseconds),
//                                       ),
//                                       child: Container(),
//                                     ),
//                                   ),
//                                 ),
//                                 Text(_formatDuration(totalDuration)),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             height: 80,
//                             width: double.infinity,
//                             margin: EdgeInsets.symmetric(horizontal: 20),
//                             decoration: BoxDecoration(
//                               image: DecorationImage(
//                                 image: AssetImage(
//                                   'assets/icon/waveform_placeholder.png',
//                                 ),
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 30.0,
//                       vertical: 10,
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(icon: Icon(Icons.shuffle), onPressed: null),
//                         IconButton(
//                           icon: Icon(Icons.skip_previous),
//                           onPressed: () async {
//                             _musicControllerStore.seek(Duration.zero);
//                             _musicControllerStore.playPrevious(
//                               currentIndex:
//                                   (_musicControllerStore.getCurrentMusicIndex ==
//                                           0)
//                                       ? (_musicControllerStore
//                                               .AllMusic!
//                                               .length -
//                                           1)
//                                       : _musicControllerStore
//                                               .getCurrentMusicIndex -
//                                           1,
//                               previoudPlay:
//                                   _musicControllerStore
//                                       .AllMusic![(_musicControllerStore
//                                               .getCurrentMusicIndex ==
//                                           0)
//                                       ? (_musicControllerStore
//                                               .AllMusic!
//                                               .length -
//                                           1)
//                                       : _musicControllerStore
//                                               .getCurrentMusicIndex -
//                                           1],
//                             );
//                           },
//                         ),
//                         Container(
//                           height: 70,
//                           width: 70,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Colors.blue,
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
//                         IconButton(
//                           icon: Icon(Icons.skip_next),
//                           onPressed: () {
//                             _musicControllerStore.playNext(
//                               currentIndex:
//                                   (_musicControllerStore.AllMusic!.length - 1 ==
//                                           _musicControllerStore
//                                               .getCurrentMusicIndex)
//                                       ? 0
//                                       : _musicControllerStore
//                                               .getCurrentMusicIndex +
//                                           1,
//                               nextplay:
//                                   _musicControllerStore
//                                       .AllMusic![(_musicControllerStore
//                                                   .AllMusic!
//                                                   .length -
//                                               1 ==
//                                           _musicControllerStore
//                                               .getCurrentMusicIndex)
//                                       ? 0
//                                       : _musicControllerStore
//                                               .getCurrentMusicIndex +
//                                           1],
//                             );
//                           },
//                         ),
//                         IconButton(icon: Icon(Icons.repeat), onPressed: null),
//                       ],
//                     ),
//                   ),
//                   Spacer(),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(duration.inMinutes);
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return '$minutes:$seconds';
//   }
// }

// class WaveformPainter extends CustomPainter {
//   final double progress;

//   WaveformPainter({required this.progress});

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint =
//         Paint()
//           ..strokeWidth = 2.0
//           ..strokeCap = StrokeCap.round;

//     final waveCount = 60;
//     final space = size.width / waveCount;
//     final baseHeight = size.height / 2;

//     for (int i = 0; i < waveCount; i++) {
//       final heightFactor = Random(i).nextDouble();
//       final height = heightFactor * size.height;
//       paint.color = (i / waveCount) < progress ? Colors.blue : Colors.black;
//       canvas.drawLine(
//         Offset(i * space, baseHeight - height / 2),
//         Offset(i * space, baseHeight + height / 2),
//         paint,
//       );
//     }
//   }

//   @override
//   bool shouldRepaint(covariant WaveformPainter oldDelegate) =>
//       oldDelegate.progress != progress;
// }

import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:boilerplate_new_version/widgets/bottom_downloadedMusicPlayer_bar.dart';
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

  @override
  Widget build(BuildContext context) {
     MusicListModule music =
        ModalRoute.of(context)!.settings.arguments as MusicListModule;

    return Observer(
      builder: (context) 
      {
      music = _musicControllerStore.recentMusic;
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
                              _musicControllerStore.playPrevious(
                              currentIndex:  (_musicControllerStore.getCurrentMusicIndex == 0) ? (_musicControllerStore.AllMusic!.length - 1) : _musicControllerStore.getCurrentMusicIndex-1,
                              previoudPlay:  _musicControllerStore.AllMusic![(_musicControllerStore.getCurrentMusicIndex == 0) ? (_musicControllerStore.AllMusic!.length - 1) : _musicControllerStore.getCurrentMusicIndex-1],
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
                              _musicControllerStore.playNext(
                              currentIndex:  (_musicControllerStore.AllMusic!.length-1 == _musicControllerStore.getCurrentMusicIndex) ? 0 : _musicControllerStore.getCurrentMusicIndex+1,
                              nextplay:  _musicControllerStore.AllMusic![(_musicControllerStore.AllMusic!.length-1 == _musicControllerStore.getCurrentMusicIndex) ? 0 :_musicControllerStore.getCurrentMusicIndex+1],
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
