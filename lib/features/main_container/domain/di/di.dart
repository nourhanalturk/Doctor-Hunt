import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/features/main_container/presentation/controller/main_container_controller.dart';
import 'package:tender/features/profile/domain/di/di.dart';
import '../../../../config/di/di.dart';
import '../../data/data_source/sign_out_data_source.dart';
import '../../data/repository/sign_out_repository.dart';
import '../usecase/sign_out_usecase.dart';

initMainContainerRequest() {
  if (!GetIt.I.isRegistered<SignOutDataSource>()) {
    instance.registerLazySingleton<SignOutDataSource>(
      () => SignOutDataSourceImpl(instance<SupabaseClient>()),
    );
  }

  if (!GetIt.I.isRegistered<SignOutRepository>()) {
    instance.registerLazySingleton<SignOutRepository>(
      () => SignOutRepositoryImpl(instance(), instance()),
    );
  }

  if (!GetIt.I.isRegistered<SignOutUseCase>()) {
    instance.registerFactory<SignOutUseCase>(
      () => SignOutUseCase(instance<SignOutRepository>()),
    );
  }
}

disposeMainContainerRequest() {
  if (GetIt.I.isRegistered<SignOutUseCase>()) {
    instance.unregister<SignOutUseCase>();
  }

  if (GetIt.I.isRegistered<SignOutRepository>()) {
    instance.unregister<SignOutRepository>();
  }

  if (GetIt.I.isRegistered<SignOutDataSource>()) {
    instance.unregister<SignOutDataSource>();
  }
}

initMainContainer() {
  initMainContainerRequest();
  disposeProfile();
  if (!Get.isRegistered<MainContainerController>()) {
    Get.put<MainContainerController>(MainContainerController());
  }
}

disposeMainContainer() {
  disposeMainContainerRequest();
  if (Get.isRegistered<MainContainerController>()) {
    Get.delete<MainContainerController>();
  }
}
