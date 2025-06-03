import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/features/medicine_orders/model/medicine_item_model.dart';

class MedicineOrdersController extends GetxController {
  TextEditingController search = TextEditingController();
  List<MedicineItemModel> items = [
    MedicineItemModel(
      title: ManagerStrings.guideToMedicine,
      imagePath: ManagerImages.guidOrders,
    ),
    MedicineItemModel(
      title: ManagerStrings.prescriptionRelatedIssues,
      imagePath: ManagerImages.prescriptionIssues,
    ),
    MedicineItemModel(
      title: ManagerStrings.orderStatus,
      imagePath: ManagerImages.orderStatus,
    ),
    MedicineItemModel(
      title: ManagerStrings.orderDelivery,
      imagePath: ManagerImages.orderDelivery,
    ),
    MedicineItemModel(
      title: ManagerStrings.paymentsAndRefunds,
      imagePath: ManagerImages.paymentRefunds,
    ),
    MedicineItemModel(
      title: ManagerStrings.orderReturns,
      imagePath: ManagerImages.orderReturns,
    )
  ];

}
