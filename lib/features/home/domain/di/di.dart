import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:tender/features/bookings/domain/di/di.dart';
import 'package:tender/features/chat/domain/di/di.dart';
import 'package:tender/features/doctor_appointment/domain/di/di.dart';
import 'package:tender/features/favorites/domain/di/di.dart';
import 'package:tender/features/home/presentation/controller/home_controller.dart';
import 'package:tender/features/login/domain/di/di.dart';
import 'package:tender/features/register/domain/di/di.dart';
import 'package:tender/features/splash/domain/di.dart';
import '../../../../config/di/di.dart';
import '../../../main_container/domain/di/di.dart';
import '../../data/data_source/home_data_remote_data_source.dart';
import '../../data/repository/home_data_repository.dart';
import '../usecase/home_usecase.dart';

initHomeRequest() {
  if (!GetIt.I.isRegistered<HomeRemoteDataSource>()) {
    instance.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl());
  }

  if (!GetIt.I.isRegistered<HomeRepository>()) {
    instance.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(instance(), instance()));
  }

  if (!GetIt.I.isRegistered<HomeUsecase>()) {
    instance.registerFactory<HomeUsecase>(
        () => HomeUsecase(instance<HomeRepository>()));
  }
}

disposeHomeRequest() {
  if (GetIt.I.isRegistered<HomeRemoteDataSource>()) {
    instance.unregister<HomeRemoteDataSource>();
  }

  if (GetIt.I.isRegistered<HomeRepository>()) {
    instance.unregister<HomeRepository>();
  }

  if (GetIt.I.isRegistered<HomeUsecase>()) {
    instance.unregister<HomeUsecase>();
  }
}

initHome() {
  initHomeRequest();
  initMainContainer();
  disposeChats();
  disposeBooking();
  disposeDoctorAppointments();
  if (!Get.isRegistered<HomeController>()) {
    Get.put<HomeController>(HomeController());
  }
}

disposeHome() {
  disposeHomeRequest();
  if (Get.isRegistered<HomeController>()) {
    Get.delete<HomeController>();
  }
}
