import 'package:get/get.dart';
import '../../presentation/controller/medicine_orders_controller.dart';

initMedicineOrders (){
  if(!Get.isRegistered<MedicineOrdersController>()){
    Get.put<MedicineOrdersController>(MedicineOrdersController());
  }
}

disposeMedicineOrders(){
  if(Get.isRegistered<MedicineOrdersController>()){
    Get.delete<MedicineOrdersController>();
  }
}