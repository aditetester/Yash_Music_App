import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
import 'package:mobx/mobx.dart';

class BottomMusicPlayerBar extends StatelessWidget {
  final MusicControllerStore musicControllerStore;

  const BottomMusicPlayerBar({Key? key, required this.musicControllerStore})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Theme.of(context).appBarTheme.backgroundColor, //Colors.teal.shade900,
      child: Container(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Song Thumbnail and Info
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Observer(
                    builder: (context) {
                      return CircleAvatar(
                        backgroundImage:
                            musicControllerStore.recentMusic.image
                                    .toString()
                                    .isNotEmpty
                                ? NetworkImage(
                                  musicControllerStore.recentMusic.image
                                      .toString(),
                                )
                                : AssetImage('assets/icon/icon.png'),
                        radius: 20,
                      );
                    },
                  ),
                ),
                Container(
                  width: 230,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        musicControllerStore.recentMusic.title.toString(), // You can use dynamic title if available
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,     
                        ),
                       maxLines: 1,
                      ),
                      Text(
                        musicControllerStore.recentMusic.subtitle.toString(), // Replace with dynamic artist name if available
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Play and Pause Buttons
            Row(
              children: [
                Observer(
                  builder: (context) {
                    return IconButton(
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
                          // Play the last played or default song
                          musicControllerStore.play(
                            musicControllerStore.recentPlay.toString(),
                          );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
