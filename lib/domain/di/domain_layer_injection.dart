import 'package:boilerplate_new_version/domain/di/module/usecase_module.dart';

class DomainLayerInjection {
  static Future<void> configureDomainLayerInjection() async {
    await UseCaseModule.configureUseCaseModuleInjection();
  }
}
