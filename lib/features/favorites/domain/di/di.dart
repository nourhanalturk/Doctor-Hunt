import 'package:get/get.dart';
import 'package:tender/features/favorites/presentation/controller/favorites_controller.dart';

initFavorites(){
  if(!Get.isRegistered<FavoritesController>()){
    Get.put<FavoritesController>(FavoritesController());
  }
}

disposeFavorites(){
  if(Get.isRegistered<FavoritesController>()){
    Get.delete<FavoritesController>();
  }
}