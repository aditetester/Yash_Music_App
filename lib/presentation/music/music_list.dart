import 'package:flutter/material.dart';

class MusicList extends StatefulWidget {
  const MusicList({super.key});

  @override
  State<MusicList> createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  @override
  Widget build(BuildContext context) {
    String subcategoryId ="";
    // final String subcategoryId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text('Music List'), centerTitle: true),
      body: ListView.builder(
        itemCount:3 ,
        itemBuilder: (context, index) {
          
          return ListTile(
            tileColor: Color.fromRGBO(32, 60, 60, 1),
            leading: CircleAvatar(
              backgroundColor: Colors.teal.shade200,
              backgroundImage: NetworkImage('assets/placeholder.png'), // Replace with actual image asset if available
              child: subcategoryId != '' ? Icon(
                      Icons.music_note,
                      color: Colors.white,
                    )
                  :null
            ),
            title: Text("song['title']!"),
            subtitle: Text("song['details']!"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.download, ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("'Downloading ['title']}'")),
                    );
                  },
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'Play') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("'Playing ['title']}'")),
                      );
                    } else if (value == 'Add to Playlist') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("'['title']} added to playlist'")),
                      );
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'Play',
                      child: Text('Play'),
                    ),
                    PopupMenuItem(
                      value: 'Add to Playlist',
                      child: Text('Add to Playlist'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
