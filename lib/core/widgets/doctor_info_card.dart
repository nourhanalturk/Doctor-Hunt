import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/core/extensions/extensions.dart';
import '../../features/favorites/presentation/controller/favorites_controller.dart';
import '../resources/manager_colors.dart';
import '../resources/manager_font_size.dart';
import '../resources/manager_font_weight.dart';
import '../resources/manager_height.dart';
import '../resources/manager_icons.dart';
import '../resources/manager_opacity.dart';
import '../resources/manager_radius.dart';
import '../resources/manager_strings.dart';
import '../resources/manager_styles.dart';
import '../resources/manager_width.dart';

Widget doctorInfoCard({required void Function()? onFavoritePressed,
  required String? doctorRate,
  required String? doctorName,
  required String? coastByHour,
  required String? image,
  required void Function()? onTap,
  int? doctorId,
  String? doctorSpeciality,
  double? cardHeight,
  double? cardWidth,
  bool? isFavInfoShown,
  double? imageRadius}) {
  var size = MediaQuery
      .of(Get.context!)
      .size;


  return Padding(
    padding: EdgeInsets.symmetric(
      horizontal: ManagerWidth.w5,
    ),
    child: GestureDetector(
      onTap:onTap,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: cardHeight ?? size.height * ManagerOpacity.op0_2,
          width: cardWidth ?? size.width * ManagerOpacity.op0_33,
          decoration: BoxDecoration(
            color: ManagerColors.white,
            borderRadius: BorderRadius.circular(
              ManagerRadius.r12,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  right: ManagerWidth.w8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GetBuilder<FavoritesController>(
                      builder: (controller) {
                        bool isFav = controller.isFavorite(doctorId.onNull());

                        return IconButton(
                          onPressed: () async {
                            final user =
                                Supabase.instance.client.auth.currentUser;

                            if (user == null) {
                              print('User not authenticated!');
                              Get.snackbar('Error', 'Please login first');
                              return;
                            }

                            controller.toggleFavorite(user.id, doctorId.onNull());
                          },
                          icon: Icon(
                            isFav
                                ? ManagerIcons.favoriteFilled
                                : ManagerIcons.favorite,
                            color: isFav
                                ? ManagerColors.redColor
                                : ManagerColors.blueBell,
                          ),
                        );
                      },
                    ),
                    const Spacer(),
                    Icon(
                      ManagerIcons.star,
                      color: ManagerColors.yellow,
                    ),
                    Text(
                      doctorRate.onNull(),
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s16,
                        color: ManagerColors.lightBlack,
                      ),
                    )
                  ],
                ),
              ),
              Center(
                child: CircleAvatar(
                  radius: imageRadius ?? ManagerRadius.r30,
                  backgroundImage: NetworkImage(image.onNull()),
                ),
              ),
              Center(
                child: Text(doctorName.onNull(),
                    style: TextStyle(
                      fontSize: ManagerFontSize.s18,
                      color: ManagerColors.lightBlack,
                      fontWeight: ManagerFontWeight.bold,
                    )),
              ),
              if (isFavInfoShown ?? false)
                Center(
                  child: Text(
                    doctorSpeciality.onNull(),
                    style: TextStyle(
                      fontSize: ManagerFontSize.s15,
                      color: ManagerColors.primaryColor,
                      fontWeight: ManagerFontWeight.medium,
                    ),
                  ),
                ),
              SizedBox(
                height: ManagerHeight.h1,
              ),
              isFavInfoShown ?? false
                  ? SizedBox()
                  : Center(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: ManagerStrings.dollarSign,
                        style: TextStyle(
                          color: ManagerColors.primaryColor,
                          fontSize: ManagerFontSize.s12,
                        ),
                      ),
                      TextSpan(
                        text: '$coastByHour ${ManagerStrings.byHour}',
                        style: TextStyle(
                          color: ManagerColors.blueBell,
                          fontSize: ManagerFontSize.s12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
