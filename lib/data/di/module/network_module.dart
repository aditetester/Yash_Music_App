import 'package:boilerplate_new_version/data/network/apis/subCategories/subCategories_api.dart';

import '../../../core/data/network/dio/configs/dio_configs.dart';
import '../../../core/data/network/dio/dio_client.dart';
import '../../network/apis/categories/categories_api.dart';
import '/core/data/network/constants/network_constants.dart';
import 'package:event_bus/event_bus.dart';
import '../../../di/service_locator.dart';

class NetworkModule {
  static Future<void> configureNetworkModuleInjection() async {
    // event bus:---------------------------------------------------------------
    getIt.registerSingleton<EventBus>(EventBus());

    // dio:---------------------------------------------------------------------
    getIt.registerSingleton<DioConfigs>(
      const DioConfigs(baseUrl: NetworkConstants.baseUrl),
    );
    getIt.registerSingleton<DioClient>(DioClient(dioConfigs: getIt()));

    // api's:-------------------------------------------------------------------
    getIt.registerSingleton<CategoriesApi>(CategoriesApi(getIt<DioClient>()));
    getIt.registerSingleton<SubCategoriesApi>(SubCategoriesApi(getIt<DioClient>()));
    
  }
}
