import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_icons.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/categories_container.dart';
import 'package:tender/core/widgets/content_card.dart';
import 'package:tender/core/widgets/doctor_info_card.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/features/home/presentation/controller/home_controller.dart';
import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_radius.dart';
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
        return AppScaffold(
          body: ListView(
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
                                '${ManagerStrings.hi} ${CacheData.getUserName().onNull()}',
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
                          Align(
                            alignment: Alignment.topCenter,
                            child: CircleAvatar(
                              radius: ManagerRadius.r30,
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
                          controller: TextEditingController(),
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
                height: size.height * ManagerOpacity.op0_07,
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
                padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: size.height * ManagerOpacity.op0_25,
                    width: size.width * ManagerOpacity.op0_33,
                    decoration: BoxDecoration(
                      color: ManagerColors.primaryColor,
                      borderRadius: BorderRadius.circular(
                        ManagerRadius.r25,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * ManagerOpacity.op0_03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
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
                  horizontal: ManagerWidth.w20,
                ),
                child: SizedBox(
                  height: size.height * ManagerOpacity.op0_4,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.popularDoctors.length,
                    itemBuilder: (BuildContext context, int index) {
                      var model = controller.popularDoctors[index];
                      return contentCard(
                        image:model.image.onNull(),
                        doctorName: model.name.onNull(),
                        onTap: () {
                          controller.navigateToDoctorDetails(model.id);
                        },
                        doctorSpecialty:model.specialty,
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
                  horizontal: ManagerWidth.w20,
                ),
                child: SizedBox(
                  height: size.height * ManagerOpacity.op0_4,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.featuredDoctors.length,
                    itemBuilder: (BuildContext context, int index) {
                      var model = controller.featuredDoctors[index];
                      return doctorInfoCard(
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
        );
      },
    );
  }
}
