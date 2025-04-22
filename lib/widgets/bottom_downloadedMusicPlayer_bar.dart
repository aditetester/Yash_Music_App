import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';

class BottomDownloadedMusicPlayerBar extends StatelessWidget {
  final MusicControllerStore musicControllerStore;

  const BottomDownloadedMusicPlayerBar({Key? key, required this.musicControllerStore})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final image = musicControllerStore.recentDownloadedMusicPlay.image.toString();
        if (image.isEmpty) {
          return const SizedBox.shrink(); // Hide the widget
        }

        return GestureDetector(
          onTap: () {
             Navigator.of(context).pushNamed(Routes.musicPlayerDownloadedScreen, arguments:  musicControllerStore.recentDownloadedMusicPlay);
                           
          },
          child: BottomAppBar(
            color: Theme.of(context).appBarTheme.backgroundColor,
            child: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Song Thumbnail and Info
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(image),
                          radius: 20,
                        ),
                      ),
                      Container(
                        width: 230,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              musicControllerStore.recentDownloadedMusicPlay.title.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                            Text(
                              musicControllerStore.recentDownloadedMusicPlay.subtitle
                                  .toString(),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Play and Pause Buttons
                  IconButton(
                    icon: Icon(
                      musicControllerStore.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    color: Colors.white,
                    iconSize: 40,
                    onPressed: () {
                      if (musicControllerStore.isPlaying) {
                        musicControllerStore.pause();
                      } else {
                        musicControllerStore.play(
                          musicControllerStore.recentPlay.toString(),
                        );
                      }
                    },
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
