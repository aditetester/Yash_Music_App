import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerHandler extends BaseAudioHandler {
  final AudioPlayer _audioPlayer;

  AudioPlayerHandler(this._audioPlayer, List<MediaItem> mediaItems) {
    queue.add(mediaItems);

    _audioPlayer.currentIndexStream.listen((index) {
      if (index != null && queue.value.isNotEmpty) {
        mediaItem.add(queue.value[index]);
      }
    });

    _audioPlayer.playbackEventStream.listen((event) {
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          _audioPlayer.playing ? MediaControl.pause : MediaControl.play,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
        },
        playing: _audioPlayer.playing,
        updatePosition: _audioPlayer.position,
        bufferedPosition: _audioPlayer.bufferedPosition,
        speed: _audioPlayer.speed,
        queueIndex: _audioPlayer.currentIndex,
      ));
    });
  }

  @override
  Future<void> playMediaItem(MediaItem mediaItem) async {
    try {
      final index = queue.value.indexWhere((item) => item.id == mediaItem.id);
      if (index != -1) {
        await _audioPlayer.setAudioSource(
          ConcatenatingAudioSource(
            children: queue.value
                .map((item) => AudioSource.uri(Uri.parse(item.id)))
                .toList(),
          ),
          initialIndex: index,
        );
       this.mediaItem.add(mediaItem);
        await _audioPlayer.play();
      }
    } catch (e) {
      print('Error playing media item: $e');
    }
  }

  @override
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  @override
  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  @override
  Future<void> stop() async {
    await _audioPlayer.stop();
  }
}
