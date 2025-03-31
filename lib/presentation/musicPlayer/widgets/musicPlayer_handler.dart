import 'package:boilerplate_new_version/di/service_locator.dart';
import 'package:boilerplate_new_version/domain/entity/music_list/musicList.dart';
import 'package:boilerplate_new_version/presentation/musicPlayer/store/musicController/music_controller_store.dart';
import 'package:flutter/material.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
 final MusicControllerStore _musicControllerStore =
      getIt<MusicControllerStore>();
  AudioPlayer _player;
  MusicListModule? music;
  String audioUrl =
      "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";

  AudioPlayerHandler(this._player) {
    
    init();
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    _notifyAudioHandler();
  }

  Future<void> init() async {
    try {
      await _player.setUrl(audioUrl);
      _notifyAudioHandler();
    } catch (e) {
      print("Error loading audio: $e");
    }
  }

  void _notifyAudioHandler() {
    
    final recentPlay = _musicControllerStore.recentMusic;
   
      mediaItem.add(
        MediaItem(
          id: recentPlay.id.toString(),
          album: recentPlay.subCategoryName.toString(),
          title: recentPlay.title.toString(),
          artist: recentPlay.subtitle.toString(),
          
          duration: _player.duration,
          artUri: Uri.parse(
            recentPlay.image.toString(),
          ), // Placeholder album art
        ),
      );
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    _notifyAudioHandler();
    return PlaybackState(
      controls: [
        MediaControl.rewind,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.fastForward,
      ],
      androidCompactActionIndices: [0, 1, 2],
      playing: _player.playing,
      processingState: _player.processingState.toAudioProcessingState(),
      updatePosition: _player.position,
      updateTime: DateTime.now(),
    );
  }

  @override
  Future<void> play() async {
    if (_player.processingState == ProcessingState.idle) {
      await _player.setUrl(audioUrl);
    }
    await _player.play();
    _notifyAudioHandler();
  }

  @override
  Future<void> pause() async {
    await _player.pause();
    _notifyAudioHandler();
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    return super.stop();
  }

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  @override
  Future<void> onSkipToNext() async {
    await seek(
      _player.position + Duration(seconds: 10),
    ); // Skip 10 seconds ahead
  }

  @override
  Future<void> onSkipToPrevious() async {
    await seek(_player.position - Duration(seconds: 10)); // Rewind 10 seconds
  }
  

  Future<void> nextPlay(String nextUrl) async {
    try {
      await _player.stop();
      await _player.setUrl(nextUrl);
      await _player.play();
      audioUrl = nextUrl;
      _notifyAudioHandler();
    } catch (e) {
      print("Error playing next track: $e");
    }
  }
}

extension on ProcessingState {
  AudioProcessingState toAudioProcessingState() {
    switch (this) {
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
        throw Exception("Invalid ProcessingState");
    }
  }
}
