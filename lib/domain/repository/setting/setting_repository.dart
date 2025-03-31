import 'dart:async';

abstract class SettingRepository {
  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value);

  bool get isDarkMode;

 Future<void> changeIsPlaying(bool value);

  bool get isPlaying;
}
