import 'dart:async';

abstract class SettingRepository {
  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value);

  bool get isDarkMode;

}
