import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/widgets/favorite_doctor_card.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/core/widgets/modern_care_header.dart';
import 'package:tender/core/widgets/modern_empty_state.dart';
import 'package:tender/features/favorites/presentation/controller/favorites_controller.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  Widget _doctorGrid({
    required int count,
    required IndexedWidgetBuilder itemBuilder,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: count,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemBuilder: itemBuilder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FavoritesController>(
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async => controller.loadFavoriteDoctors(),
          child: AppScaffold(
            body: ListView(
              padding: const EdgeInsets.only(bottom: 96),
              children: [
                ModernCareHeader(
                  icon: Icons.favorite_border_rounded,
                  title: ManagerStrings.favoriteDoctors,
                  subtitle: ManagerStrings.favoriteDoctorsSubtitle,
                  countLabel:
                      '${controller.doctors.length} ${ManagerStrings.doctors}',
                ),
                const SizedBox(height: 28),
                if (controller.isLoading)
                  _doctorGrid(
                    count: 4,
                    itemBuilder: (_, __) => favoriteDoctorShimmer(),
                  ),
                if (!controller.isLoading && controller.favorites.isEmpty)
                  modernEmptyState(
                    icon: Icons.favorite_border_rounded,
                    title: ManagerStrings.thereIsNoFavorites,
                    subtitle: ManagerStrings.favoriteDoctorsSubtitle,
                    buttonText: ManagerStrings.searchDoctors,
                    onPressed: () => Get.toNamed(Routes.home),
                  ),
                if (!controller.isLoading && controller.favorites.isNotEmpty)
                  _doctorGrid(
                    count: controller.doctors.length,
                    itemBuilder: (_, index) {
                      final model = controller.doctors[index];
                      return favoriteDoctorCard(
                        name: model.name,
                        specialty: model.specialty,
                        imageUrl: model.image,
                      );
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
