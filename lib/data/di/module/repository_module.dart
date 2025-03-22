import 'dart:async';
import '../../repository/setting/setting_repository_impl.dart';
import '../../sharedpref/shared_preference_helper.dart';
import '../../../domain/repository/setting/setting_repository.dart';


import '../../../di/service_locator.dart';

class RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));

  }
}
