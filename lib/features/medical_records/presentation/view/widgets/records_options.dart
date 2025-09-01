import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';

Widget recordOptions(
    {required void Function() onTakeAPhotoPressed,
    required void Function() onUploadFromGalleryPressed,
    required void Function() onUploadFilePressed}) {
  return Padding(
    padding: EdgeInsets.only(
      top: ManagerHeight.h15,
      left: ManagerHeight.h15,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ManagerStrings.addARecord,
          style: getBoldTextStyle(
            fontSize: ManagerFontSize.s25,
            color: ManagerColors.black,
          ),
        ),
        Row(
          children: [
            SvgPicture.asset(ManagerImages.camera,),
            TextButton(
              onPressed: onTakeAPhotoPressed,
              child: Text(
                ManagerStrings.takeAPhoto,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s15,
                  color: ManagerColors.blueBell,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(ManagerImages.imageIcon,),
            TextButton(
              onPressed: onUploadFromGalleryPressed,
              child: Text(
                ManagerStrings.uploadFromGallery,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s15,
                  color: ManagerColors.blueBell,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(ManagerImages.pdfIcon,),

            TextButton(
              onPressed: onUploadFilePressed,
              child: Text(
                ManagerStrings.uploadFiles,
                style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s15,
                  color: ManagerColors.blueBell,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
