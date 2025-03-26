import 'package:boilerplate_new_version/presentation/music/widgets/addPlayList_dialogBox.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:flutter/material.dart';

class MusicItems extends StatelessWidget {
  final String id;
  final String title;
  final String subTitle;
  final String image;

  MusicItems({
    super.key,
    required this.id,
    required this.title,
    required this.subTitle,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: Color.fromRGBO(32, 60, 60, 1),
      leading: CircleAvatar(
        backgroundColor: Colors.teal.shade200,
        backgroundImage: NetworkImage(
          image,
        ), // Replace with actual image asset if available
        child: Icon(Icons.music_note),
      ),
      title: Text(
        title,
        maxLines: 1,
        style: TextStyle(
          fontSize: 19, // Restrict to a single line
          overflow: TextOverflow.ellipsis,
        ),
      ),
      subtitle: Text(subTitle, style: TextStyle(fontSize: 10)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("'Downloading $title")));
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Play') {
                Navigator.of(context).pushNamed(Routes.musicPlayer);
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
