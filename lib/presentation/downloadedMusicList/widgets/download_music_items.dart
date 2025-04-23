import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/presentation/downloadedMusicList/store/download_list_store.dart';
import 'package:boilerplate_new_version/presentation/music/widgets/addPlayList_dialogBox.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:dio/dio.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadedMusicItems extends StatefulWidget {
  final DownloadedListModule music;
  final int index;
  DownloadedMusicItems({super.key, required this.index, required this.music});

  @override
  State<DownloadedMusicItems> createState() => _DownloadedMusicItemsState();
}

class _DownloadedMusicItemsState extends State<DownloadedMusicItems> {
  @override
  Widget build(BuildContext context) {
    final MusicControllerStore _musicControllerStore =
        getIt<MusicControllerStore>();

    return ListTile(
      tileColor: Color.fromRGBO(32, 60, 60, 1),
      leading: CircleAvatar(
        backgroundColor: Colors.teal.shade200,
        backgroundImage: NetworkImage(
          widget.music.image.toString(),
        ), // Replace with actual image asset if available
        child: Icon(Icons.music_note),
      ),
      title: Text(
        widget.music.title.toString(),
        maxLines: 1,
        style: TextStyle(
          fontSize: 19, // Restrict to a single line
          overflow: TextOverflow.ellipsis,
        ),
      ),
      subtitle: Text(
        '${widget.music.subtitle.toString()}',
        style: TextStyle(fontSize: 10),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Observer(
            builder:
                (context) => Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.offline_pin_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Play') {
                _musicControllerStore.playDownloadNext(
                  currentIndex: widget.index,
                  nextplay: widget.music,
                );
                Navigator.of(context).pushNamed(
                  Routes.musicPlayerDownloadedScreen,
                  arguments: widget.music,
                );
                // ScaffoldMessenger.of(
                //   context,
                // ).showSnackBar(SnackBar(content: Text("'Playing $title")));
              } else if (value == 'Add to Playlist') {
                showAddToPlaylistDialog(context);
              }
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(value: 'Play', child: Text('Play')),
                  PopupMenuItem(
                    value: 'Add to Playlist',
                    child: Text('Add to Playlist'),
                  ),
                ],
          ),
        ],
      ),
    );
  }

  void showAddToPlaylistDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddToPlaylistDialog();
      },
    );
  }
}
