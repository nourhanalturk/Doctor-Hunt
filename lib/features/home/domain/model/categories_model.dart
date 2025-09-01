import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoriesModel {
  Color? firstColor;
  Color? secondColor;
  String? icon;
  Function()? onTap;

  CategoriesModel({
    required this.firstColor,
    required this.secondColor,
    required this.icon,
    required this.onTap,
  });
}
