import 'package:get/get.dart';
import 'package:tender/core/resources/manager_strings.dart';

import '../../../../core/resources/manager_colors.dart';
import '../../../../core/resources/manager_images.dart';
import '../../../home/domain/model/categories_model.dart';

class HealthCheckupsController extends GetxController {
  List<CategoriesModel> categories = [
    CategoriesModel(
      firstColor: ManagerColors.blue,
      secondColor: ManagerColors.purple,
      icon: ManagerImages.home,
      onTap: () {},
    ),
    CategoriesModel(
      firstColor: ManagerColors.primaryColor,
      secondColor: ManagerColors.white,
      icon: ManagerImages.practoLabs,
      onTap: () {},
    ),
    CategoriesModel(
      firstColor: ManagerColors.orange,
      secondColor: ManagerColors.lightOrange,
      icon: ManagerImages.eReports,
      onTap: () {},
    ),
    CategoriesModel(
      firstColor: ManagerColors.darkOrange,
      secondColor: ManagerColors.lightOrange,
      icon: ManagerImages.freeFollowUp,
      onTap: () {},
    ),
  ];
  List<String> categoriesTitles = [
    ManagerStrings.freeHomeSamplePickup,
    ManagerStrings.practoAssociateLabs,
    ManagerStrings.eReportsIn24To72Hours,
    ManagerStrings.freeFollowUpWithDoctor,
  ];
}
