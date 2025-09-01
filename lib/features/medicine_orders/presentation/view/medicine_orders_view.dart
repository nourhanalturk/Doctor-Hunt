import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_icons.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/custom_app_bar.dart';
import 'package:tender/core/widgets/main_background.dart';
import 'package:tender/core/widgets/profile_textField.dart';

import 'package:tender/features/medicine_orders/presentation/view/widgets/medicine_item.dart';

import '../controller/medicine_orders_controller.dart';

class MedicineOrdersView extends StatelessWidget {
  const MedicineOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MedicineOrdersController>(
      builder: (controller) {
        var size = MediaQuery.of(context).size;
        return AppScaffold(
          body: Padding(
            padding: EdgeInsets.all(
              ManagerWidth.w20,
            ),
            child: Column(
              children: [
                customAppBar(
                  appBarTitle: ManagerStrings.medicinesOrders,
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_02,
                ),
                profileTextField(
                  hintText: ManagerStrings.search,
                  controller: controller.search,
                  prefixIcon: Icon(
                    ManagerIcons.search,
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
                SizedBox(
                  height: size.height * ManagerOpacity.op0_05,
                ),
                Expanded(
                  child: GridView.builder(
                    itemCount: controller.items.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: ManagerWidth.w10,
                      mainAxisSpacing: ManagerWidth.w10,
                      childAspectRatio:ManagerOpacity.op0_94,
                    ),
                    itemBuilder: (context, index) {
                      var model = controller.items[index];
                      return medicineItem(
                        title: model.title.onNull(),
                        imagePath: model.imagePath.onNull(),
                      );
                    },
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
