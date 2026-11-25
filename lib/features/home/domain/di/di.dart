import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/features/bookings/domain/di/di.dart';
import 'package:tender/features/chat/domain/di/di.dart';
import 'package:tender/features/doctor_appointment/domain/di/di.dart';
import 'package:tender/features/home/presentation/controller/home_controller.dart';
import 'package:tender/features/home/domain/usecase/get_patient_full_name_usecase.dart';
import 'package:tender/features/login/domain/di/di.dart';
import 'package:tender/features/profile/domain/di/di.dart';
import 'package:tender/features/profile_records_info/domain/di/di.dart';
import '../../../../config/di/di.dart';
import '../../../main_container/domain/di/di.dart';
import '../../data/data_source/home_data_remote_data_source.dart';
import '../../data/data_source/sign_out_data_source.dart';
import '../../data/repository/home_data_repository.dart';
import '../../data/repository/sign_out_repository.dart';
import '../usecase/home_usecase.dart';
import '../usecase/sign_out_usecase.dart';

initHomeRequest() {
  if (!GetIt.I.isRegistered<HomeRemoteDataSource>()) {
    instance.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(instance<SupabaseClient>()),
    );
  }

  if (!GetIt.I.isRegistered<HomeRepository>()) {
    instance.registerLazySingleton<HomeRepository>(
        () => HomeRepositoryImpl(instance(), instance()));
  }

  if (!GetIt.I.isRegistered<HomeUsecase>()) {
    instance.registerFactory<HomeUsecase>(
        () => HomeUsecase(instance<HomeRepository>()));
  }

  if (!GetIt.I.isRegistered<GetPatientFullNameUseCase>()) {
    instance.registerFactory<GetPatientFullNameUseCase>(
      () => GetPatientFullNameUseCase(instance<HomeRepository>()),
    );
  }

  if (!GetIt.I.isRegistered<SignOutDataSource>()) {
    instance.registerLazySingleton<SignOutDataSource>(
      () => SignOutDataSourceImpl(instance<SupabaseClient>()),
    );
  }

  if (!GetIt.I.isRegistered<SignOutRepository>()) {
    instance.registerLazySingleton<SignOutRepository>(
      () => SignOutRepositoryImpl(instance(), instance()),
    );
  }

  if (!GetIt.I.isRegistered<SignOutUseCase>()) {
    instance.registerFactory<SignOutUseCase>(
      () => SignOutUseCase(instance<SignOutRepository>()),
    );
  }
}

disposeHomeRequest() {
  if (GetIt.I.isRegistered<SignOutUseCase>()) {
    instance.unregister<SignOutUseCase>();
  }

  if (GetIt.I.isRegistered<SignOutRepository>()) {
    instance.unregister<SignOutRepository>();
  }

  if (GetIt.I.isRegistered<SignOutDataSource>()) {
    instance.unregister<SignOutDataSource>();
  }

  if (GetIt.I.isRegistered<HomeRemoteDataSource>()) {
    instance.unregister<HomeRemoteDataSource>();
  }

  if (GetIt.I.isRegistered<HomeRepository>()) {
    instance.unregister<HomeRepository>();
  }

  if (GetIt.I.isRegistered<HomeUsecase>()) {
    instance.unregister<HomeUsecase>();
  }

  if (GetIt.I.isRegistered<GetPatientFullNameUseCase>()) {
    instance.unregister<GetPatientFullNameUseCase>();
  }
}

initHome() {
  initHomeRequest();
  disposeChats();
  disposeBooking();
  disposeDoctorAppointments();
  disposeProfileRecordsInfo();
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
