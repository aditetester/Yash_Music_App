import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  final AudioPlayer _audioPlayer = AudioPlayer();

  MyAudioHandler() {
    _audioPlayer.playerStateStream.listen((playerState) {
      playbackState.add(
        PlaybackState(
          controls: [
            MediaControl.play,
            MediaControl.pause,
            MediaControl.stop,
            MediaControl.skipToNext,
            MediaControl.skipToPrevious,
          ],
          processingState: _mapProcessingState(playerState.processingState),
          playing: playerState.playing,
          updatePosition: _audioPlayer.position,
          bufferedPosition: _audioPlayer.bufferedPosition,
          speed: _audioPlayer.speed,
          updateTime: DateTime.now(),
        ),
      );
    });
  }

  @override
  Future<void> play() => _audioPlayer.play();

  @override
  Future<void> pause() => _audioPlayer.pause();

  @override
  Future<void> stop() => _audioPlayer.stop();

  @override
  Future<void> seek(Duration position) => _audioPlayer.seek(position);

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    await _audioPlayer.setUrl(mediaItem.id); // Set the audio URL
  }

  AudioProcessingState _mapProcessingState(ProcessingState state) {
    switch (state) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
        return AudioProcessingState.loading;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
      default:
        throw ArgumentError('Invalid state: $state');
    }
  }
}
