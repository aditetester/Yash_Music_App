import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:boilerplate_new_version/presentation/music_player/store/musicController/music_controller_store.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class BottomDownloadedMusicPlayerBar extends StatefulWidget {
  final MusicControllerStore musicControllerStore;
  final bool isTapEnable;

  const BottomDownloadedMusicPlayerBar({
    Key? key,
    this.isTapEnable = true,
    required this.musicControllerStore,
  }) : super(key: key);


  @override
  State<BottomDownloadedMusicPlayerBar> createState() => _BottomDownloadedMusicPlayerBarState();
}

class _BottomDownloadedMusicPlayerBarState extends State<BottomDownloadedMusicPlayerBar> {

 String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final image = widget.musicControllerStore.recentDownloadedMusicPlay.image.toString();
        if (image.isEmpty) {
          return const SizedBox.shrink(); // Hide the widget
        }

        return GestureDetector(
          onTap:
              widget.isTapEnable
                  ? () {
                    Navigator.of(context).pushNamed(
                      Routes.musicPlayerDownloadedScreen,
                      arguments: widget.musicControllerStore.recentDownloadedMusicPlay,
                    );
                  }
                  : () {},
          child: BottomAppBar(
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Container(
              height: 4.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Song Thumbnail and Info
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5.0,
                          right: 10,
                          left: 5,
                          bottom: 5,
                        ),

                        child: Center(
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                height: 7.h,
                                width: 12.w,
                                child: Observer(
                                  builder: (context) {
                                    final currentPosition =
                                        widget
                                            .musicControllerStore
                                            .currentPosition;
                                    final totalDuration =
                                        widget
                                            .musicControllerStore
                                            .totalDuration;
                                    if (_formatDuration(currentPosition) ==
                                        _formatDuration(totalDuration)) {
                                      widget.musicControllerStore.playDownloadNext(
                                        currentIndex:
                                            (widget
                                                            .musicControllerStore
                                                            .AllDownloadedMusic!
                                                            .length -
                                                        1 ==
                                                    widget
                                                        .musicControllerStore
                                                        .getCurrentMusicIndex)
                                                ? 0
                                                : widget
                                                        .musicControllerStore
                                                        .getCurrentMusicIndex +
                                                    1,
                                        nextplay:
                                            widget
                                                .musicControllerStore
                                                .AllDownloadedMusic![(widget
                                                            .musicControllerStore
                                                            .AllDownloadedMusic!
                                                            .length -
                                                        1 ==
                                                    widget
                                                        .musicControllerStore
                                                        .getCurrentMusicIndex)
                                                ? 0
                                                : widget
                                                        .musicControllerStore
                                                        .getCurrentMusicIndex +
                                                    1],
                                      );
                                    }

                                    return CircularProgressIndicator(
                                      value:
                                          currentPosition.inMilliseconds /
                                          (totalDuration.inMilliseconds == 0
                                              ? 1
                                              : totalDuration.inMilliseconds),
                                      strokeWidth: 2,
                                      backgroundColor: Colors.blue.shade100,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                            Colors.blueAccent,
                                          ),
                                    );
                                  },
                                ),
                              ),
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(image),
                              ),

                              Container(
                                width: 4.w,
                                height: 5.h,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // child: CircleAvatar(
                        //   backgroundImage: NetworkImage(image),
                        //   radius: 20,
                        // ),
                      ),
                      Container(
                        width: 55.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              widget.musicControllerStore.recentDownloadedMusicPlay.title
                                  .toString(),
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                            Text(
                              widget.musicControllerStore.recentDownloadedMusicPlay.subtitle
                                  .toString(),
                              style: const TextStyle(
                                color: Color.fromARGB(255, 87, 87, 87),
                                fontFamily: 'Poppins',
                                fontSize: 12,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 8.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0x241DA2F4),
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            widget.musicControllerStore.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                          color: Color.fromARGB(255, 29, 162, 244),
                          iconSize: 28,
                          onPressed: () {
                            if (widget.musicControllerStore.isPlaying) {
                              widget.musicControllerStore.pause();
                            } else {
                              widget.musicControllerStore.play(
                                widget.musicControllerStore.recentPlay
                                    .toString(),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Observer(
                        builder: (context) {
                          return Container(
                            width: 8.w,
                            child: GestureDetector(
                              onTap: () async {
                                await widget.musicControllerStore
                                    .ChangeIsLyrics(
                                      val:
                                          !widget.musicControllerStore.isLyrics,
                                    );
                              },
                              child:
                                  widget.musicControllerStore.isLyrics
                                      ? SvgPicture.asset(
                                        'assets/svg/lyrics_playing.svg',
                                        height: 28,
                                        width: 28,
                                      )
                                      : SvgPicture.asset(
                                        'assets/svg/playlist_icon.svg',
                                        height: 25,
                                        width: 25,
                                      ),
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 1.w),
                      // IconButton(
                      //     padding: EdgeInsets.zero,
                      //     icon: Icon(
                      //      Icons.playlis
                      //     ),
                      //     color: Color.fromARGB(255, 29, 162, 244),
                      //     iconSize: 28,
                      //     onPressed: () {
                      //       if (musicControllerStore.isPlaying) {
                      //         musicControllerStore.pause();
                      //       } else {
                      //         musicControllerStore.play(
                      //           musicControllerStore.recentPlay.toString(),
                      //         );
                      //       }
                      //     },
                      //   ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}




//   @override
//   Widget build(BuildContext context) {
//     return Observer(
//       builder: (_) {
//         final image = widget.musicControllerStore.recentDownloadedMusicPlay.image.toString();
//         if (image.isEmpty) {
//           return const SizedBox.shrink(); // Hide the widget
//         }

//         return GestureDetector(
//           onTap: () {
//              Navigator.of(context).pushNamed(Routes.musicPlayerDownloadedScreen, arguments:  widget.musicControllerStore.recentDownloadedMusicPlay);
                           
//           },
//           child: BottomAppBar(
//             color: Theme.of(context).appBarTheme.backgroundColor,
//             child: Container(
//               height: 60,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Song Thumbnail and Info
//                   Row(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: CircleAvatar(
//                           backgroundImage: NetworkImage(image),
//                           radius: 20,
//                         ),
//                       ),
//                       Container(
//                         width: 230,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Text(
//                               widget.musicControllerStore.recentDownloadedMusicPlay.title.toString(),
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.bold,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               maxLines: 1,
//                             ),
//                             Text(
//                               widget.musicControllerStore.recentDownloadedMusicPlay.subtitle
//                                   .toString(),
//                               style: const TextStyle(
//                                 color: Colors.white70,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                   // Play and Pause Buttons
//                   IconButton(
//                     icon: Icon(
//                       widget.musicControllerStore.isPlaying
//                           ? Icons.pause
//                           : Icons.play_arrow,
//                     ),
//                     color: Colors.white,
//                     iconSize: 40,
//                     onPressed: () {
//                       if (widget.musicControllerStore.isPlaying) {
//                         widget.musicControllerStore.pause();
//                       } else {
//                         widget.musicControllerStore.play(
//                           widget.musicControllerStore.recentPlay.toString(),
//                         );
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
