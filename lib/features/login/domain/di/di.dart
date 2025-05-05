import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/features/login/presentation/controller/login_controller.dart';
import 'package:tender/features/out_boarding/domain/di.dart';
import 'package:tender/features/register/domain/di/di.dart';
import 'package:tender/features/splash/domain/di.dart';

import '../../../../core/network/app_api.dart';
import '../../data/data_source/login_data_source.dart';
import '../../data/repository/login_repository.dart';
import '../usecase/login_usecase.dart';

initLoginRequest() {
  if (!GetIt.I.isRegistered<LoginRemoteDataSource>()) {
    instance.registerLazySingleton<LoginRemoteDataSource>(
        () => LoginRemoteDataSourceImplement(instance<AppService>()));
  }

  if (!GetIt.I.isRegistered<LoginRepository>()) {
    instance.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImplement(instance(), instance()));
  }

  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
        () => LoginUseCase(instance<LoginRepository>()));
  }
}

disposeLoginRequest() {
  if (GetIt.I.isRegistered<LoginRemoteDataSource>()) {
    instance.unregister<LoginRemoteDataSource>();
  }

  if (GetIt.I.isRegistered<LoginRepository>()) {
    instance.unregister<LoginRepository>();
  }

  if (GetIt.I.isRegistered<LoginUseCase>()) {
    instance.unregister<LoginUseCase>();
  }
}

initLogin() {
  initLoginRequest();
  disposeOutBoarding();
  disposeSplash();
  disposeRegister();
  if (!Get.isRegistered<LoginController>()) {
    Get.put<LoginController>(LoginController());
  }
}

disposeLogin() {
  disposeLoginRequest();
  if (Get.isRegistered<LoginController>()) {
    Get.delete<LoginController>();
  }
}
