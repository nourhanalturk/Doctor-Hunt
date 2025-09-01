import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_font_weight.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/custom_app_bar.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/core/widgets/main_button.dart';
import 'package:tender/features/health-checkups/presentation/controller/health_checkups_controller.dart';

import '../../../../core/widgets/categories_container.dart';
import '../../../home/domain/model/categories_model.dart';

class HealthCheckupsView extends StatelessWidget {
  const HealthCheckupsView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<HealthCheckupsController>(
      builder: (controller) {
        return AppScaffold(
          body: Padding(
            padding: EdgeInsets.all(
              ManagerWidth.w20,
            ),
            child: ListView(
              children: [
                customAppBar(
                  appBarTitle: ManagerStrings.healthCheckups,
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_03,
                ),
                Text(
                  ManagerStrings.getFullBodyHealthCheckups,
                  style: TextStyle(
                    fontSize: ManagerFontSize.s23,
                    color: ManagerColors.black,
                    fontWeight: ManagerFontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_01,
                ),
                Text(
                  ManagerStrings.upTo45OffAndHealthcareBack,
                  style: getRegularTextStyle(
                    fontSize: ManagerFontSize.s16,
                    color: ManagerColors.primaryColor,
                  ),
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_4,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: ManagerWidth.w10,
                      //  mainAxisSpacing: ManagerWidth.w10,
                      // childAspectRatio:ManagerOpacity.op0_94,
                    ),
                    itemCount: controller.categories.length,
                    itemBuilder: (context, index) {
                      CategoriesModel model = controller.categories[index];
                      return Row(
                        children: [
                          categoriesContainer(
                            height: size.height * ManagerOpacity.op0_07,
                            width: size.width * ManagerOpacity.op0_17,
                            firstColor: model.firstColor,
                            secondColor: model.secondColor,
                            icon: model.icon,
                            onTap: model.onTap,
                          ),
                          SizedBox(
                            width: ManagerWidth.w4,
                          ),
                          Text(
                            controller.categoriesTitles[index],
                            style: getMediumTextStyle(
                              fontSize: ManagerFontSize.s14,
                              color: ManagerColors.black,
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_01,
                ),
                Text(
                  ManagerStrings.recommendForYou,
                  style: TextStyle(
                    fontSize: ManagerFontSize.s23,
                    color: ManagerColors.black,
                    fontWeight: ManagerFontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_01,
                ),
                Container(
                  height: size.height * ManagerOpacity.op0_4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ManagerColors.white,
                    borderRadius: BorderRadius.circular(
                      ManagerRadius.r12,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(ManagerWidth.w10,),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: size.height * ManagerOpacity.op0_01,
                        ),
                        Text(
                          ManagerStrings.advancedYoungIndianHealthCheckup,
                          style: TextStyle(
                            fontSize: ManagerFontSize.s16,
                            color: ManagerColors.black,
                            fontWeight: ManagerFontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: size.height * ManagerOpacity.op0_01,
                        ),
                        Text(
                          ManagerStrings.idealForAged21To40,
                          style: TextStyle(
                            fontSize: ManagerFontSize.s14,
                            color: ManagerColors.blueBell,
                          ),
                        ),
                        SizedBox(
                          height: size.height * ManagerOpacity.op0_01,
                        ),
                        Container(
                          height: size.height * ManagerOpacity.op0_05,
                          width: size.width * ManagerOpacity.op0_4,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ManagerColors.primaryColor,
                            ),
                            color: ManagerColors.transparent,
                            borderRadius: BorderRadius.circular(
                              ManagerRadius.r12,
                            ),
                          ),
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              ManagerStrings.testsIncluded,
                              style: TextStyle(
                                fontSize: ManagerFontSize.s14,
                                color: ManagerColors.primaryColor,
                              ),
                            ),
                          ),
                        ),

                        Container(
                          height: size.height * ManagerOpacity.op0_15,
                          width:double.infinity,
                        ),
                        //todo : add image here

                        Row(
                          children: [
                            Column(
                              children: [
                                // TextSpan(
                                //   children: [
                                //     TextSpan(
                                //       text: ManagerStrings.dollarSign,
                                //       style: TextStyle(
                                //         color: ManagerColors.primaryColor,
                                //         fontSize: ManagerFontSize.s12,
                                //       ),
                                //     ),
                                //     TextSpan(
                                //       text: '$coastByHour ${ManagerStrings.byHour}',
                                //       style: TextStyle(
                                //         color: ManagerColors.blueBell,
                                //         fontSize: ManagerFontSize.s12,
                                //       ),
                                //     ),
                                //   ],
                                // ),,
                                Text(
                                  ManagerStrings.healthCashbackTnC,
                                  style: TextStyle(
                                    color: ManagerColors.blueBell,
                                    fontSize: ManagerFontSize.s12,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            mainButton(
                              minWidth: size.width*ManagerOpacity.op0_2,
                              height: size.height*ManagerOpacity.op0_05,
                              onPressed: () {},
                              buttonText: ManagerStrings.bookNow,
                            )
                          ],
                        )
                      ],
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
