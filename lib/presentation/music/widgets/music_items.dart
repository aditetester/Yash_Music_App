import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:boilerplate_new_version/di/service_locator.dart';
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

class MusicItems extends StatefulWidget {
  final MusicListModule music;

  MusicItems({super.key, required this.music});

  @override
  State<MusicItems> createState() => _MusicItemsState();
}

class _MusicItemsState extends State<MusicItems> {
  final DownloadListStore _downloadListStore = getIt<DownloadListStore>();
  String musicUrl = "";
  CancelToken? _cancelToken;
  List<int> _partialData = [];
  int _downloadedBytes = 0;
  int _totalBytes = 0;
  bool _downloading = false;
  bool _paused = false;
  double get _progress => _totalBytes == 0 ? 0 : _downloadedBytes / _totalBytes;

  Future<void> _handleDownload() async {
    if (_downloading && !_paused) {
      _pauseDownload();
    } else {
      await _startOrResumeDownload();
    }
  }

  void _pauseDownload() {
    _paused = true;
    _cancelToken?.cancel();
  }

  Future<void> _startOrResumeDownload() async {
    PermissionStatus status = await Permission.manageExternalStorage.status;

    if (status.isDenied || status.isRestricted || status.isLimited) {
      status = await Permission.manageExternalStorage.request();
    }

    if (status.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Permission permanently denied. Enable it in settings.",
          ),
          action: SnackBarAction(
            label: "Settings",
            onPressed: () => openAppSettings(),
          ),
        ),
      );
      return;
    }

    if (!status.isGranted) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Permission denied")));
      return;
    }

    _cancelToken = CancelToken();

    setState(() {
      _downloading = true;
      _paused = false;
    });

    try {
      var dio = Dio();
      final response = await dio.get<ResponseBody>(
        musicUrl,
        options: Options(
          responseType: ResponseType.stream,
          headers:
              _downloadedBytes > 0 ? {"Range": "bytes=$_downloadedBytes-"} : {},
        ),
        cancelToken: _cancelToken,
      );

      final contentLengthHeader = response.headers.value(
        HttpHeaders.contentLengthHeader,
      );
      final isPartialContent = response.statusCode == 206;

      int total = int.tryParse(contentLengthHeader ?? '0') ?? 0;
      if (isPartialContent) {
        _totalBytes = _downloadedBytes + total;
      } else {
        _totalBytes = total;
        _partialData.clear();
        _downloadedBytes = 0;
      }

      final completer = Completer<void>();
      final stream = response.data!.stream;

      stream.listen(
        (chunk) {
          _partialData.addAll(chunk);
          _downloadedBytes += chunk.length;
          setState(() {});
        },
        onDone: () async {
          Uint8List fullData = Uint8List.fromList(_partialData);

          String? savedPath = await FileSaver.instance.saveFile(
            name: widget.music.title.toString(),
            bytes: fullData,
            ext: "mp3",
            mimeType: MimeType.mp3,
          );

          if (savedPath.isNotEmpty && savedPath.isNotEmpty) {
            await _downloadListStore.insertDownloadedMusicList(
              widget.music.id.toString(),
              widget.music.title.toString(),
              widget.music.subtitle.toString(),
              savedPath,
            );
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Download complete!\nSaved to:\n$savedPath"),
              ),
            );
          }

          setState(() {
            _downloading = false;
            _paused = false;
            _partialData.clear();
            _downloadedBytes = 0;
            _totalBytes = 0;
          });

          completer.complete();
        },
        onError: (e) {
          if (_paused) {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Download paused")));
          } else {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Download failed: $e")));
          }
          completer.complete();
        },
        cancelOnError: true,
      );

      await completer.future;
    } catch (e) {
      if (!_paused) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Download error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    musicUrl = widget.music.audio.toString();
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
          if (_downloading) Text("${(_progress * 100).toStringAsFixed(0)}%"),
          Observer(
            builder: (context) =>  Stack(
              alignment: Alignment.center,
              children: [
                if (_downloading) CircularProgressIndicator(value: _progress),
                _downloadListStore.getDownloadedList?.contains(widget.music.title.toString()) ?? false ?  IconButton(
                  icon: Icon(Icons.offline_pin_outlined) , onPressed: () {},):
                IconButton(
                  icon:
                      _downloading
                          ? (_paused ? Icon(Icons.play_arrow) : Icon(Icons.pause))
                          : Icon(Icons.download),
                  onPressed: () {
                    _handleDownload();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "'Downloading ${widget.music.subtitle.toString()}",
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
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
