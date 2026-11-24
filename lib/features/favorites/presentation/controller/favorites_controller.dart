import 'package:get/get.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/features/favorites/domain/use_case/favorites_usecase.dart';
import 'package:tender/features/favorites/domain/use_case/get_current_user_id_usecase.dart';
import 'package:tender/features/favorites/domain/use_case/get_favorite_doctors_usecase.dart';

import '../../domain/model/favorite_doctor_model.dart';

class FavoritesController extends GetxController {
  final Set<int> favoriteIds = {};
  bool isLoading = false;

  Set<int> get favorites => favoriteIds;

  Future<void> loadFavorites(String userId) async {
    GetFavoritesUseCase useCase = instance<GetFavoritesUseCase>();

    final result = await useCase.execute(userId);
    result.fold(
      (failure) => Get.snackbar('Error', failure.message),
      (ids) {
        favoriteIds.clear();
        favoriteIds.addAll(ids);
      },
    );

    update();
  }

  Future<void> toggleFavorite(String userId, int doctorId) async {
    ToggleFavoriteUseCase useCase = instance<ToggleFavoriteUseCase>();

    final wasFavorite = favoriteIds.contains(doctorId);

    wasFavorite ? favoriteIds.remove(doctorId) : favoriteIds.add(doctorId);
    update();

    final result = await useCase.execute({
      'userId': userId,
      'doctorId': doctorId,
    });

    result.fold(
      (failure) {
        wasFavorite ? favoriteIds.add(doctorId) : favoriteIds.remove(doctorId);
        update();
        Get.snackbar('Error', failure.message);
      },
      (_) => null,
    );
  }

  bool isFavorite(int doctorId) => favoriteIds.contains(doctorId);

  List<FavoriteDoctorModel> doctors = [];

  Future<void> loadFavoriteDoctors() async {
    isLoading = true;
    update();

    final userIdResult = await instance<GetCurrentUserIdUseCase>().execute();
    final userId = userIdResult.fold(
      (failure) => null,
      (id) => id,
    );

    if (userId != null) {
      final result = await instance<GetFavoriteDoctorsUseCase>().execute(
        userId,
      );
      result.fold(
        (failure) => null,
        (favoriteDoctors) => doctors = favoriteDoctors,
      );
    }

    isLoading = false;
    update();
  }

  Future<void> _loadCurrentUserFavorites() async {
    final userIdResult = await instance<GetCurrentUserIdUseCase>().execute();
    final userId = userIdResult.fold(
      (failure) => null,
      (id) => id,
    );
    if (userId != null) {
      await loadFavorites(userId);
    }
  }

  @override
  void onInit() {
    loadFavoriteDoctors();
    _loadCurrentUserFavorites();
    super.onInit();
  }
}
