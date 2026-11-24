import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/internet_checker/internet_checker.dart';
import 'package:tender/features/main_container/domain/di/di.dart';
import 'package:tender/features/profile/data/data_source/current_user_data_source.dart';
import 'package:tender/features/profile/data/data_source/profile_remote_data_source.dart';
import 'package:tender/features/profile/data/repository/current_user_repository.dart';
import 'package:tender/features/profile/data/repository/profile_repository.dart';
import 'package:tender/features/profile/domain/usecase/get_current_user_id_usecase.dart';
import 'package:tender/features/profile/domain/usecase/profile_usecase.dart';
import 'package:tender/features/profile/domain/usecase/update_patient_usecase.dart';
import 'package:tender/features/profile/domain/usecase/upload_profile_image_usecase.dart';
import 'package:tender/features/profile/presentation/controller/profile_controller.dart';

initProfileRequest() {
  if (!GetIt.I.isRegistered<CurrentUserDataSource>()) {
    instance.registerLazySingleton<CurrentUserDataSource>(
      () => CurrentUserDataSourceImpl(instance<SupabaseClient>()),
    );
  }
  if (!GetIt.I.isRegistered<CurrentUserRepository>()) {
    instance.registerLazySingleton<CurrentUserRepository>(
      () => CurrentUserRepositoryImpl(instance<CurrentUserDataSource>()),
    );
  }
  if (!GetIt.I.isRegistered<GetCurrentUserIdUseCase>()) {
    instance.registerFactory<GetCurrentUserIdUseCase>(
      () => GetCurrentUserIdUseCase(instance<CurrentUserRepository>()),
    );
  }

  if (!GetIt.I.isRegistered<ProfileRemoteDataSource>()) {
    instance.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImplementation(instance<SupabaseClient>()),
    );
  }
  if (!GetIt.I.isRegistered<ProfileRepository>()) {
    instance.registerLazySingleton<ProfileRepository>(
      () => ProfileRepositoryImplementation(
        instance<NetworkInfo>(),
        instance<ProfileRemoteDataSource>(),
      ),
    );
  }

  if (!GetIt.I.isRegistered<ProfileUsecase>()) {
    instance.registerFactory<ProfileUsecase>(
      () => ProfileUsecase(instance<ProfileRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<UpdatePatientUseCase>()) {
    instance.registerFactory<UpdatePatientUseCase>(
      () => UpdatePatientUseCase(instance<ProfileRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<UploadProfileImageUseCase>()) {
    instance.registerFactory<UploadProfileImageUseCase>(
      () => UploadProfileImageUseCase(instance<ProfileRepository>()),
    );
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

  if (GetIt.I.isRegistered<UploadProfileImageUseCase>()) {
    instance.unregister<UploadProfileImageUseCase>();
  }
  if (GetIt.I.isRegistered<UpdatePatientUseCase>()) {
    instance.unregister<UpdatePatientUseCase>();
  }
  if (GetIt.I.isRegistered<ProfileUsecase>()) {
    instance.unregister<ProfileUsecase>();
  }
  if (GetIt.I.isRegistered<ProfileRepository>()) {
    instance.unregister<ProfileRepository>();
  }
  if (GetIt.I.isRegistered<ProfileRemoteDataSource>()) {
    instance.unregister<ProfileRemoteDataSource>();
  }
  if (GetIt.I.isRegistered<GetCurrentUserIdUseCase>()) {
    instance.unregister<GetCurrentUserIdUseCase>();
  }
  if (GetIt.I.isRegistered<CurrentUserRepository>()) {
    instance.unregister<CurrentUserRepository>();
  }
  if (GetIt.I.isRegistered<CurrentUserDataSource>()) {
    instance.unregister<CurrentUserDataSource>();
  }
}
