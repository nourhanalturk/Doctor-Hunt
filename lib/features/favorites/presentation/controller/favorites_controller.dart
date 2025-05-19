import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/features/doctor_details/domain/di/di.dart';
import 'package:tender/features/favorites/domain/use_case/favorites_usecase.dart';

import '../../../doctor_details/data/request/doctor_details_request.dart';
import '../../../doctor_details/domain/model/doctor_details_model.dart';
import '../../../doctor_details/domain/usecase/doctor_details_usecase.dart';
import '../../domain/model/favorite_doctor_model.dart';

class FavoritesController extends GetxController {
  final Set<int> favoriteIds = {};
  bool isLoading = false;

  Set<int> get favorites => favoriteIds;

  Future<void> loadFavorites(String userId) async {
    GetFavoritesUseCase useCase = instance<GetFavoritesUseCase>();
    isLoading = true;
    update();

    final result = await useCase.execute(userId);
    result.fold(
      (failure) => Get.snackbar('Error', failure.message),
      (ids) {
        favoriteIds.clear();
        favoriteIds.addAll(ids);
      },
    );

    isLoading = false;
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
    //if (favoriteIds.isEmpty) return;
    initDoctorDetailsRequest();
    String userId = supabase.auth.currentUser!.id ;

    final response = await supabase
        .from('favorite_doctors_view')
        .select()
        .eq('user_id', userId);

    final favoriteDoctors = response.map((e) => FavoriteDoctorModel.fromJson(e)).toList();

    doctors =favoriteDoctors;
    update();
    print(doctors);

  }

  @override
  void onInit() {
    final userId = Supabase.instance.client.auth.currentUser;
    loadFavorites(userId!.id);
    loadFavoriteDoctors();
    super.onInit();
  }
}
