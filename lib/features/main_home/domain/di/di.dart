import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/features/bookings/domain/di/di.dart';
import 'package:tender/features/chat/domain/di/di.dart';
import 'package:tender/features/home/domain/di/di.dart';
import 'package:tender/features/main_container/domain/di/di.dart';
import 'package:tender/features/main_home/presentation/controller/main_home_controller.dart';
import 'package:tender/features/settings/domain/di/di.dart';
import '../../../../config/di/di.dart';
import '../../../favorites/domain/di/di.dart';
import '../../../home/presentation/controller/home_controller.dart';
import '../../../main_container/presentation/controller/main_container_controller.dart';
import '../../data/data_source/auth_state_remote_data_source.dart';
import '../../data/repository/auth_state_repository.dart';
import '../../data/repository/network_connection_repository.dart';
import '../usecase/check_internet_connection_usecase.dart';
import '../usecase/watch_auth_state_usecase.dart';

initMainHomeRequest() {
  if (!GetIt.I.isRegistered<AuthStateRemoteDataSource>()) {
    instance.registerLazySingleton<AuthStateRemoteDataSource>(
      () => AuthStateRemoteDataSourceImpl(instance<SupabaseClient>()),
    );
  }

  if (!GetIt.I.isRegistered<AuthStateRepository>()) {
    instance.registerLazySingleton<AuthStateRepository>(
      () => AuthStateRepositoryImpl(instance<AuthStateRemoteDataSource>()),
    );
  }

  if (!GetIt.I.isRegistered<WatchAuthStateUseCase>()) {
    instance.registerFactory<WatchAuthStateUseCase>(
      () => WatchAuthStateUseCase(instance<AuthStateRepository>()),
    );
  }

  if (!GetIt.I.isRegistered<NetworkConnectionRepository>()) {
    instance.registerLazySingleton<NetworkConnectionRepository>(
      () => NetworkConnectionRepositoryImpl(instance()),
    );
  }

  if (!GetIt.I.isRegistered<CheckInternetConnectionUseCase>()) {
    instance.registerFactory<CheckInternetConnectionUseCase>(
      () => CheckInternetConnectionUseCase(
        instance<NetworkConnectionRepository>(),
      ),
    );
  }
}

disposeMainHomeRequest() {
  if (GetIt.I.isRegistered<CheckInternetConnectionUseCase>()) {
    instance.unregister<CheckInternetConnectionUseCase>();
  }

  if (GetIt.I.isRegistered<NetworkConnectionRepository>()) {
    instance.unregister<NetworkConnectionRepository>();
  }

  if (GetIt.I.isRegistered<WatchAuthStateUseCase>()) {
    instance.unregister<WatchAuthStateUseCase>();
  }

  if (GetIt.I.isRegistered<AuthStateRepository>()) {
    instance.unregister<AuthStateRepository>();
  }

  if (GetIt.I.isRegistered<AuthStateRemoteDataSource>()) {
    instance.unregister<AuthStateRemoteDataSource>();
  }
}

/// Feature-local DI switching that used to live inside [MainHomeController].
void initMainHomeTab(int index) {
  switch (index) {
    case 0:
      initHome();
      initFavorites();
      break;
    case 1:
      initBookings();
      break;
    case 2:
      initFavorites();
      break;
    case 3:
      initSettings();
      break;
  }
}

initMainHome() {
  print("MainHome init called");
  initMainHomeRequest();
  initMainContainerRequest();
  if (!Get.isRegistered<MainContainerController>()) {
    Get.put(MainContainerController());
  }
  initMainHomeTab(0);

  if (!Get.isRegistered<MainHomeController>()) {
    Get.put(MainHomeController());
  }
}

disposeMainHome() {
  disposeMainHomeRequest();
  if (Get.isRegistered<MainHomeController>()) Get.delete<MainHomeController>();
  if (Get.isRegistered<MainContainerController>()) {
    Get.delete<MainContainerController>();
  }
  if (Get.isRegistered<HomeController>()) Get.delete<HomeController>();
}
