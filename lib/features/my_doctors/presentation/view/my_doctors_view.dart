import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/custom_app_bar.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/my_doctors/presentation/controller/my_doctors_controller.dart';

import '../../../../core/resources/manager_images.dart';
import '../../../../core/resources/manager_opacity.dart';
import '../../../../core/resources/manager_radius.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/doctor_info_card.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/shimmer/favorites_shimmer_view.dart';

class MyDoctorsView extends StatelessWidget {
  const MyDoctorsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyDoctorsController>(
      builder: (controller) {
        var size = MediaQuery.of(Get.context!).size;

        return controller.isLoading == 1
            ? const FavoritesShimmerView()
            : controller.doctorIds.isEmpty
                ? EmptyStateWidget(
                    appBarTitle: ManagerStrings.favoriteDoctors,
                    title: ManagerStrings.thereIsNoFavorites,
                    subtitle: ManagerStrings.searchDoctors,
                    buttonText: ManagerStrings.searchDoctors,
                    onPressed: () {
                      Get.toNamed(Routes.home);
                    },
                    svgAssetPath: ManagerImages.medicalRecords,
                  )
                : RefreshIndicator(
                    onRefresh: () {
                      return controller.getMyDoctors();
                    },
                    child: AppScaffold(
                      body: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(
                              ManagerHeight.h20,
                            ),
                            child: customAppBar(
                              appBarTitle: ManagerStrings.myDoctors,
                            ),
                          ),
                          Expanded(
                            child: GridView.builder(
                              padding: EdgeInsets.all(
                                ManagerWidth.w20,
                              ),
                              itemCount: controller.data.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: ManagerWidth.w10,
                                mainAxisSpacing: ManagerWidth.w10,
                                childAspectRatio: ManagerOpacity.op0_7,
                              ),
                              itemBuilder: (context, index) {
                                var model = controller.data[index];
                                return doctorInfoCard(
                                  doctorId: controller.doctorIds[index],
                                  onTap: () {},
                                  cardHeight:
                                      size.height * ManagerOpacity.op0_4,
                                  imageRadius: ManagerRadius.r70,
                                  onFavoritePressed: () {},
                                  cardWidth: size.width * ManagerOpacity.op0_8,
                                  doctorRate: '',
                                  doctorName: model.doctorName,
                                  coastByHour: '',
                                  image: model.image,
                                  isFavInfoShown: true,
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ));
      },
    );
  }
}
