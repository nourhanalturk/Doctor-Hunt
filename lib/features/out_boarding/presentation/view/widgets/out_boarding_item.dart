import 'package:flutter/cupertino.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_width.dart';

class OutBoardingItem extends StatelessWidget {
  final String image;

  final String title;

  final String subTitle;

  const OutBoardingItem({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: size.height * ManagerOpacity.op0_1,
        ),
        SizedBox(
          width: ManagerWidth.w300,
          height: ManagerHeight.h300,
          child: Image.asset(
            image,
          ),
        ),
        SizedBox(
          height: size.height * ManagerOpacity.op0_1,
        ),
        Text(
          title,
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s25,
            color: ManagerColors.lightBlack,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w30,
            vertical: ManagerHeight.h5,
          ),
          child: Text(
            subTitle,
            style: getRegularTextStyle(
              fontSize: ManagerFontSize.s14,
              color: ManagerColors.blueBell,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
