import 'dart:async';

import '../../../domain/repository/setting/setting_repository.dart';
import '../../sharedpref/shared_preference_helper.dart';

class SettingRepositoryImpl extends SettingRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  SettingRepositoryImpl(this._sharedPrefsHelper);

  // Theme: --------------------------------------------------------------------
  @override
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  @override
  bool get isDarkMode => _sharedPrefsHelper.isDarkMode;


}
