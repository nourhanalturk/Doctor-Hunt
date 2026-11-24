import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/internet_checker/internet_checker.dart';
import 'package:tender/features/doctor_details/domain/di/di.dart';
import 'package:tender/features/favorites/data/data_source/current_user_data_source.dart';
import 'package:tender/features/favorites/data/data_source/favorites_remote_data_source.dart';
import 'package:tender/features/favorites/data/repository/current_user_repository.dart';
import 'package:tender/features/favorites/data/repository/favorites_repository.dart';
import 'package:tender/features/favorites/domain/use_case/favorites_usecase.dart';
import 'package:tender/features/favorites/domain/use_case/get_current_user_id_usecase.dart';
import 'package:tender/features/favorites/domain/use_case/get_favorite_doctors_usecase.dart';
import 'package:tender/features/favorites/presentation/controller/favorites_controller.dart';

initFavoritesRequest() {
  initDoctorDetailsRequest();

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

  if (!GetIt.I.isRegistered<FavoritesRemoteDataSource>()) {
    instance.registerLazySingleton<FavoritesRemoteDataSource>(
      () => FavoritesRemoteDataSourceImpl(instance<SupabaseClient>()),
    );
  }

  if (!GetIt.I.isRegistered<FavoritesRepository>()) {
    instance.registerLazySingleton<FavoritesRepository>(
      () => FavoritesRepositoryImpl(instance(), instance<NetworkInfo>()),
    );
  }
  if (!GetIt.I.isRegistered<GetFavoritesUseCase>()) {
    instance.registerFactory<GetFavoritesUseCase>(
      () => GetFavoritesUseCase(instance<FavoritesRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<ToggleFavoriteUseCase>()) {
    instance.registerFactory<ToggleFavoriteUseCase>(
      () => ToggleFavoriteUseCase(instance<FavoritesRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<GetFavoriteDoctorsUseCase>()) {
    instance.registerFactory<GetFavoriteDoctorsUseCase>(
      () => GetFavoriteDoctorsUseCase(instance<FavoritesRepository>()),
    );
  }
}

initFavorites() {
  initFavoritesRequest();
  if (!Get.isRegistered<FavoritesController>()) {
    Get.put<FavoritesController>(FavoritesController());
  }
}

disposeFavorites() {
  if (Get.isRegistered<FavoritesController>()) {
    Get.delete<FavoritesController>();
  }

  if (GetIt.I.isRegistered<GetFavoriteDoctorsUseCase>()) {
    instance.unregister<GetFavoriteDoctorsUseCase>();
  }
  if (GetIt.I.isRegistered<ToggleFavoriteUseCase>()) {
    instance.unregister<ToggleFavoriteUseCase>();
  }
  if (GetIt.I.isRegistered<GetFavoritesUseCase>()) {
    instance.unregister<GetFavoritesUseCase>();
  }
  if (GetIt.I.isRegistered<FavoritesRepository>()) {
    instance.unregister<FavoritesRepository>();
  }
  if (GetIt.I.isRegistered<FavoritesRemoteDataSource>()) {
    instance.unregister<FavoritesRemoteDataSource>();
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
