import '../../../core/data/network/dio/configs/dio_configs.dart';
import '../../../core/data/network/dio/dio_client.dart';
import '../../network/apis/posts/post_api.dart';
import '/data/network/constants/music_api.dart';
import 'package:event_bus/event_bus.dart';
import '../../../di/service_locator.dart';

class NetworkModule {
  static Future<void> configureNetworkModuleInjection() async {
    // event bus:---------------------------------------------------------------
    getIt.registerSingleton<EventBus>(EventBus());

    // dio:---------------------------------------------------------------------
     getIt.registerSingleton<DioConfigs>(
      const DioConfigs(
        baseUrl: MusicApis.baseUrl,
      ),
    );
    getIt.registerSingleton<DioClient>(
      DioClient(dioConfigs: getIt()));

    // api's:-------------------------------------------------------------------
    getIt.registerSingleton<PostApi>(PostApi(getIt<DioClient>()));
  }
}
