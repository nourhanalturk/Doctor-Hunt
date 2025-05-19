import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/core/widgets/empty_state.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/favorites/presentation/controller/favorites_controller.dart';

import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_images.dart';
import '../../../../core/resources/manager_opacity.dart';
import '../../../../core/resources/manager_strings.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/doctor_info_card.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(Get.context!)
        .size;

    return AppScaffold(
      body: GetBuilder<FavoritesController>(
        builder: (controller) {
          return controller.favorites.isEmpty
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
              : Column(
            children: [
              Padding(
                padding: EdgeInsets.all(
                  ManagerHeight.h20,
                ),
                child: customAppBar(
                  appBarTitle: ManagerStrings.favoriteDoctors,
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding:  EdgeInsets.all(ManagerWidth.w20,),
                  itemCount: controller.doctors.length,
                  gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: ManagerWidth.w10,
                    mainAxisSpacing: ManagerWidth.w10,
                    childAspectRatio: ManagerOpacity.op0_7,
                  ),
                  itemBuilder: (context, index) {
                    var model = controller.doctors[index];
                    return doctorInfoCard(
                      cardHeight: size.height *ManagerOpacity.op0_4,
                      imageRadius: ManagerRadius.r70,
                      onFavoritePressed: () {},
                      cardWidth:size.width *ManagerOpacity.op0_8,
                      doctorRate: '',
                      doctorName: model.name,
                      coastByHour: '',
                      image: model.image,
                      doctorSpeciality: model.specialty,
                      isFavInfoShown: true,
                    );
                  },
                ),
              )


            ],
          );
        },
      ),
    );
  }
}
