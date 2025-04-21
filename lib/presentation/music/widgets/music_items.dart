import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/presentation/music/widgets/addPlayList_dialogBox.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:flutter/material.dart';

class MusicItems extends StatefulWidget {
  final MusicListModule music;
  MusicItems({super.key, required this.music});

  @override
  State<MusicItems> createState() => _MusicItemsState();
}

class _MusicItemsState extends State<MusicItems> {
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
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("'Downloading ${widget.music.subtitle.toString()}"),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Play') {
                _musicControllerStore.playNext(widget.music);
                Navigator.of(
                  context,
                ).pushNamed(Routes.musicPlayer, arguments: widget.music);
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
