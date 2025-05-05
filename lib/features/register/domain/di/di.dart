import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tender/features/register/presentation/controller/register_controller.dart';
import '../../../../config/di/di.dart';
import '../../../../core/network/app_api.dart';
import '../../../login/domain/di/di.dart';
import '../../../splash/domain/di.dart';
import '../../data/data_source/register_remote_data_source.dart';
import '../../data/repo/register_repository.dart';
import '../usecase/register_usecase.dart';

initRegisterRequest() async {
  if (!GetIt.I.isRegistered<RegisterRemoteDataSource>()) {
    instance.registerLazySingleton<RegisterRemoteDataSource>(
        () => RegisterRemoteDataSourceImplementation(instance<AppService>()));
  }

  if (!GetIt.I.isRegistered<RegisterRepository>()) {
    instance.registerLazySingleton<RegisterRepository>(
        () => RegisterRepositoryImplement(instance(), instance()));
  }

  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.registerFactory<RegisterUseCase>(
        () => RegisterUseCase(instance<RegisterRepository>()));
  }
}

disposeRegisterRequest() {
  if (GetIt.I.isRegistered<RegisterRemoteDataSource>()) {
    instance.unregister<RegisterRemoteDataSource>();
  }

  if (GetIt.I.isRegistered<RegisterRepository>()) {
    instance.unregister<RegisterRepository>();
  }

  if (GetIt.I.isRegistered<RegisterUseCase>()) {
    instance.unregister<RegisterUseCase>();
  }
}

initRegister() {
  initRegisterRequest();
  disposeLogin();
  disposeSplash();
  disposeLogin();
  if (!Get.isRegistered<RegisterController>()) {
    Get.put<RegisterController>(RegisterController());
  }
}

disposeRegister() {
  disposeRegisterRequest();
  if (Get.isRegistered<RegisterController>()) {
    Get.delete<RegisterController>();
  }
}
