import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_width.dart';
import '../../../../../core/resources/manager_strings.dart';
import '../../../../../core/widgets/main_bottom_sheet.dart';
import '../../controller/login_controller.dart';

Widget otpBottomSheet({
  required LoginController controller,
}) {
  return mainBottomSheet(
    title: ManagerStrings.enterFourDigitCode,
    subTitle: ManagerStrings.enterFourDigitCodeThatYouReceive,
    widgets: Center(
      child: Pinput(

        defaultPinTheme: PinTheme(
          width: ManagerWidth.w55,
          height: ManagerHeight.h55,
          textStyle: getBoldTextStyle(
            fontSize: ManagerFontSize.s25,
            color: ManagerColors.primaryColor,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: ManagerColors.grayColor,),
            borderRadius: BorderRadius.circular(ManagerRadius.r12,),
          ),
        ),
        onCompleted: (pin) => controller.saveCode(pin),
      ),
    ),
    onPressed: () {
      if(controller.checkOtp()){
      controller.navigateToNextPage();
      }
    },
    buttonText: ManagerStrings.keepGoing,
  );
}
