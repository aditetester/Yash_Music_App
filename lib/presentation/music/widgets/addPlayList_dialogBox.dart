import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/presentation/music_playlist_screen/store/music_playlist_store.dart';
import 'package:flutter/material.dart';

class AddToPlaylistDialog extends StatelessWidget {
 MusicListModule musicData;

  AddToPlaylistDialog({required this.musicData});

  final List<Map<String, dynamic>> playlists = [
    {
      "title": "New Playlist",
      "subtitle": "0 Songs",
      "image": null, // This will trigger the fallback icon
    },
    {
      "title": "Power of Attitude",
      "subtitle": "0 Songs",
      "image":
          "assets/images/demo_img.jpg", // Replace with real image or leave invalid to test fallback
    },
  ];


  @override
  Widget build(BuildContext context) {
    final MusicPlayListStore _musicPlayListStore = getIt<MusicPlayListStore>();
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.grey.shade100,
      child: Container(
        padding: const EdgeInsets.all(15),
        width: 290,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add to Playlist',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            Divider(color: Colors.white, thickness: 2),
            // Create new playlist
            InkWell(
              onTap: () {
                // handle new playlist creation
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text("Create new playlist", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Playlist items
            ...playlists.map((playlist) {
              return InkWell(
                onTap: () {
                  _musicPlayListStore.insertMusicPlayList(
                    id: musicData.id.toString(),
                    title: musicData.title.toString(),
                    subTitle: musicData.subtitle.toString(),
                    audio: musicData.audio.toString(),
                    image: musicData.image.toString(),
                    subCategoryId: "2",
                    subCategoryName: "Power Of Attitude",
                    lyrics: musicData.lyrics.toString(),
                  );
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Added to '${playlist["title"]}'")),
                  );
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey.shade100,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child:
                            playlist["image"] != null
                                ? Image.network(
                                  playlist["image"],
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          _fallbackIcon(),
                                )
                                : _fallbackIcon(),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            playlist["title"],
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            playlist["subtitle"],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _fallbackIcon() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Icon(Icons.music_note, color: Colors.blue),
    );
  }
}
