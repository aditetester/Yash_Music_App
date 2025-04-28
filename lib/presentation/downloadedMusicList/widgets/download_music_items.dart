import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/downloaded_list/downloaded.dart';
import 'package:boilerplate_new_version/presentation/music/widgets/addPlayList_dialogBox.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
import 'package:boilerplate_new_version/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:sizer/sizer.dart';

class DownloadedMusicItems extends StatefulWidget {
  final DownloadedListModule music;
  final int index;
  const DownloadedMusicItems({
    super.key,
    required this.index,
    required this.music,
  });

  @override
  State<DownloadedMusicItems> createState() => _DownloadedMusicItemsState();
}

class _DownloadedMusicItemsState extends State<DownloadedMusicItems> {
  final MusicControllerStore _musicControllerStore =
      getIt<MusicControllerStore>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
      child: Row(
        children: [
          // Image with play icon
          Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10), // Rounded rectangle
                child: Image.network(
                  widget.music.image ?? '',
                  height: 55,
                  width: 55,
                  fit: BoxFit.cover,
                  errorBuilder:
                      (context, error, stackTrace) => Container(
                        height: 55,
                        width: 55,
                        color: Colors.grey[300],
                        child: Icon(Icons.music_note, color: Colors.grey),
                      ),
                ),
              ),
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.play_arrow, color: Colors.white, size: 16),
              ),
            ],
          ),

          SizedBox(width: 12),

          // Title, Subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.music.title ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  widget.music.subtitle ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 9.sp,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          // Duration Text
          Text(
            "00:00",
            // _formatDuration(widget.music.duration ?? "00:00"), // safe fallback
            style: TextStyle(fontFamily: 'Poppins', fontSize: 10.sp),
          ),

          SizedBox(width: 8),

          // 3-dot menu
          PopupMenuButton<String>(
            position: PopupMenuPosition.under,
            padding: EdgeInsets.all(10),
            menuPadding: EdgeInsets.only(left: 2, right: 3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            onSelected: (value) {
              if (value == 'Add to Playlists') {
                showAddToPlaylistDialog(context);
              } else if (value == 'Share') {
                // TODO: Implement share logic
              } else if (value == 'Delete from device') {
                // TODO: Implement delete logic
              }
            },
            itemBuilder:
                (context) => [
                  PopupMenuItem(
                    value: 'Add to Playlists',
                    child: Text('Add to Playlists'),
                  ),
                  PopupMenuItem(value: 'Share', child: Text('Share')),
                  PopupMenuItem(
                    value: 'Delete from device',
                    child: Text('Delete from device'),
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

  String _formatDuration(String duration) {
    // Assuming your duration is already like "04:20"
    if (duration.isEmpty) {
      return "00:00";
    }
    return duration;
  }
}
