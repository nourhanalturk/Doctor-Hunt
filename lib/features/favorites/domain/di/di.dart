import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/features/favorites/domain/use_case/favorites_usecase.dart';
import 'package:tender/features/favorites/presentation/controller/favorites_controller.dart';

import '../../../../config/di/di.dart';
import '../../data/data_source/favorites_remote_data_source.dart';
import '../../data/repository/favorites_repository.dart';

initFavoritesRequest() {
  if (!GetIt.I.isRegistered<FavoritesRemoteDataSource>()) {
    instance.registerLazySingleton<FavoritesRemoteDataSource>(
        () => FavoritesRemoteDataSourceImpl(instance<SupabaseClient>()));
  }

  if (!GetIt.I.isRegistered<FavoritesRepository>()) {
    instance.registerLazySingleton<FavoritesRepository>(
        () => FavoritesRepository(instance()));
  }
  if (!GetIt.I.isRegistered<GetFavoritesUseCase>()) {
    instance.registerLazySingleton(
      () => GetFavoritesUseCase(instance()),
    );
  }
  if (!GetIt.I.isRegistered<ToggleFavoriteUseCase>()) {
    instance.registerLazySingleton(() => ToggleFavoriteUseCase(instance()));
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
}
