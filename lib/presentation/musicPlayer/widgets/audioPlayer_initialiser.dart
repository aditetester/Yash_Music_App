import 'package:audio_service/audio_service.dart';

import 'package:boilerplate_new_version/presentation/musicPlayer/widgets/musicPlayer_handler.dart';

class AudioPlayerInit {
  AudioHandler? audioHandler;
  AudioPlayerInit(){
    initAudioService();
  }
  Future<void> initAudioService() async {
    audioHandler = await AudioService.init(
      builder: () => AudioPlayerHandler(),
      config: AudioServiceConfig(
        androidNotificationChannelId: 'com.example.musicplayer.channel.audio',
        androidNotificationChannelName: 'Music Playback',
        androidNotificationOngoing: true,
      ),
    );
  }
}
