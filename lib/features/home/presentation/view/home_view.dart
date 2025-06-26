import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_font_weight.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_icons.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_json.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/categories_container.dart';
import 'package:tender/core/widgets/content_card.dart';
import 'package:tender/core/widgets/doctor_info_card.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/core/widgets/main_button.dart';
import 'package:tender/features/home/presentation/controller/home_controller.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_radius.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/widgets/shimmer/home_view_shimmer.dart';
import '../../domain/model/categories_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<HomeController>(
      builder: (controller) {
        SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(
            statusBarColor: ManagerColors.primaryColor,
            statusBarIconBrightness: Brightness.light,
          ),
        );
        return RefreshIndicator(
          onRefresh: () => controller.homeRequest(),
          child: AppScaffold(
            body: controller.popularDoctors.isEmpty  ? CircularProgressIndicator(): ListView(

              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: size.height * ManagerOpacity.op0_15,
                      decoration: BoxDecoration(
                        color: ManagerColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(
                            ManagerRadius.r25,
                          ),
                          bottomRight: Radius.circular(
                            ManagerRadius.r25,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top +
                              ManagerHeight.h30,
                          left: ManagerHeight.h30,
                          right: ManagerHeight.h30,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${ManagerStrings.hi} ${controller.userName}',
                                  style: getRegularTextStyle(
                                    fontSize: ManagerFontSize.s20,
                                    color: ManagerColors.white,
                                  ),
                                ),
                                Text(
                                  ManagerStrings.findYourDoctor,
                                  style: getBoldTextStyle(
                                    fontSize: ManagerFontSize.s25,
                                    color: ManagerColors.white,
                                  ),
                                )
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                controller.navigateToProfileInfo();

                              },
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: CircleAvatar(
                                  radius: ManagerRadius.r30,
                                  backgroundImage: NetworkImage(
                                    controller.userImage,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -30,
                      left: 0,
                      right: 0,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: size.width * ManagerOpacity.op0_85,
                          height: ManagerHeight.h55,
                          decoration: BoxDecoration(
                            color: ManagerColors.white,
                            borderRadius: BorderRadius.circular(
                              ManagerRadius.r12,
                            ),
                          ),
                          child: TextFormField(
                            controller: controller.searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                ManagerIcons.search,
                                color: ManagerColors.blueBell,
                              ),
                              hintText: ManagerStrings.search,
                              hintStyle: TextStyle(
                                fontSize: ManagerFontSize.s19,
                                color: ManagerColors.blueBell,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  ManagerIcons.clear,
                                  color: ManagerColors.blueBell,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_09,
                ),
                InkWell(
                    onTap: () {
                      Get.toNamed(Routes.healthCheckups);
                    },
                    child: // Replace this problematic section:
                        Center(
                      child: Container(
                        height: size.height * 0.09,
                        width: size.width * 0.7,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: size.height * 0.08,
                              width: size.width * 0.7,
                              decoration: BoxDecoration(
                                color: ManagerColors.white,
                                borderRadius:
                                    BorderRadius.circular(ManagerRadius.r20),
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(ManagerWidth.w15),
                                child: Text(
                                  ManagerStrings
                                      .newFullBodyHealthCheckupsAreAvailable,
                                  style: TextStyle(
                                    fontSize: ManagerFontSize.s14,
                                    color: ManagerColors.black,
                                    fontWeight: ManagerFontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            // Fixed Positioned widget:
                            Positioned(
                              top: -28,
                              left: (size.width * 0.7) / 2 - 25,
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  color: ManagerColors.scaffoldColor,
                                  shape: BoxShape.circle,
                                ),
                                child: Lottie.asset(
                                  ManagerJson.readMore,
                                  fit: BoxFit.cover,
                                  repeat: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_01,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    ManagerStrings.liveDoctors,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s22,
                      color: ManagerColors.lightBlack,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w20,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      controller.testNowReminder();
                    },
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        height: size.height * ManagerOpacity.op0_25,
                        width: size.width * ManagerOpacity.op0_33,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            ManagerRadius.r20,
                          ),
                          child: Stack(
                            children: [
                              Image.asset(
                                ManagerImages.liveDoctorImage,
                              ),
                              Container(
                                height: size.height * ManagerOpacity.op0_25,
                                width: size.width * ManagerOpacity.op0_33,
                                decoration: BoxDecoration(
                                    color: ManagerColors.white
                                        .withOpacity(ManagerOpacity.op0_3)),
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: size.width * ManagerOpacity.op0_19,
                                      top: ManagerHeight.h9,
                                    ),
                                    child: Container(
                                      height:
                                          size.height * ManagerOpacity.op0_03,
                                      width: size.width * ManagerOpacity.op0_12,
                                      decoration: BoxDecoration(
                                        color: ManagerColors.redColor,
                                        borderRadius: BorderRadius.circular(
                                          ManagerRadius.r4,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: size.height *
                                                ManagerOpacity.op0_01,
                                            width: size.width *
                                                ManagerOpacity.op0_05,
                                            decoration: const BoxDecoration(
                                                color: ManagerColors.white,
                                                shape: BoxShape.circle),
                                          ),
                                          Text(
                                            ManagerStrings.live,
                                            style: TextStyle(
                                              fontSize: ManagerFontSize.s13,
                                              color: ManagerColors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * ManagerOpacity.op0_07,
                                  ),
                                  SvgPicture.asset(
                                    ManagerImages.playIcon,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_03,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      controller.categories.length,
                      (index) {
                        CategoriesModel model = controller.categories[index];
                        return categoriesContainer(
                          firstColor: model.firstColor,
                          secondColor: model.secondColor,
                          icon: model.icon,
                          onTap: model.onTap,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w20,
                  ),
                  child: Text(
                    ManagerStrings.popularDoctors,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s22,
                      color: ManagerColors.lightBlack,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w10,
                  ),
                  child: SizedBox(
                    height: size.height * ManagerOpacity.op0_4,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.popularDoctors.length,
                      itemBuilder: (BuildContext context, int index) {
                        var model = controller.popularDoctors[index];
                        return contentCard(
                          image: model.image.onNull(),
                          doctorName: model.name.onNull(),
                          onTap: () {
                            controller.navigateToDoctorDetails(model.id);
                          },
                          doctorSpecialty: model.specialty,
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_07,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    ManagerStrings.featureDoctors,
                    style: getBoldTextStyle(
                      fontSize: ManagerFontSize.s22,
                      color: ManagerColors.lightBlack,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w5,
                  ),
                  child: SizedBox(
                    height: size.height * ManagerOpacity.op0_33,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.featuredDoctors.length,
                      itemBuilder: (BuildContext context, int index) {
                        var model = controller.featuredDoctors[index];
                        return doctorInfoCard(
                          doctorId: model.id,
                          onTap: () {
                            controller.navigateToDoctorDetails(model.id);
                          },
                          onFavoritePressed: () {},
                          doctorRate: model.rating.toString(),
                          doctorName: model.name,
                          coastByHour: model.coastPerHour.onNull().toString(),
                          image: model.image,
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
