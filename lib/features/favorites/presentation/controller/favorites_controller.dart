import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/storage/local/app_settings_prefs.dart';
import 'package:tender/features/doctor_details/domain/di/di.dart';
import 'package:tender/features/favorites/domain/use_case/favorites_usecase.dart';
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
    initDoctorDetailsRequest();
    final currentUser = supabase.auth.currentUser;
    if (currentUser == null) return;

    await supabase
        .from('favorite_doctors_view')
        .select()
        .eq('user_id', currentUser.id)
        .then(
      (value) {
        final favoriteDoctors =
            value.map((e) => FavoriteDoctorModel.fromJson(e)).toList();
        doctors = favoriteDoctors;
        isLoading = false;
        update();
      },
    ).catchError((e) {
      isLoading = false;
      update();
    });
  }

  @override
  void onInit() {
    loadFavoriteDoctors();
    final userId = Supabase.instance.client.auth.currentUser;
    if (userId != null) {
      loadFavorites(userId.id);
    }

    super.onInit();
  }
}
