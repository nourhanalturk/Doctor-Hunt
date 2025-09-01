import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/internet_checker/internet_checker.dart';
import 'package:tender/features/main_container/domain/di/di.dart';
import 'package:tender/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:tender/features/profile/data/repository/profile_repository.dart';
import 'package:tender/features/profile/domain/usecase/profile_usecase.dart';
import 'package:tender/features/profile/presentation/controller/profile_controller.dart';

initProfileRequest() {
  if (!GetIt.I.isRegistered<ProfileRemoteDataSource>()) {
    instance.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImplementation(),
    );
  }
  if (!GetIt.I.isRegistered<ProfileRepository>()) {
    instance.registerLazySingleton<ProfileRepository>(
            () => ProfileRepositoryImplementation(instance(),instance()));
  }

  if (!GetIt.I.isRegistered<ProfileUsecase>()) {
    instance.registerFactory<ProfileUsecase>(
            () => ProfileUsecase(instance<ProfileRepository>()));
  }
}

initProfile() {
  initProfileRequest();
  disposeMainContainer();
  if (!Get.isRegistered<ProfileController>()) {
    Get.put<ProfileController>(ProfileController());
  }
}

disposeProfile() {
  if (Get.isRegistered<ProfileController>()) {
    Get.delete<ProfileController>();
  }
}
