import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../config/di/di.dart';
import '../../data/data_source/appointment.dart';
import '../../data/repository/appointment_repository.dart';
import '../../presentation/controller/doctor_appointment_controller.dart';
import '../usecase/appointment_usecase.dart';

initAddAppointmentRequest() {
  if (!GetIt.I.isRegistered<AddAppointmentRemoteDataSource>()) {
    instance.registerLazySingleton<AddAppointmentRemoteDataSource>(
        () => AddAppointmentRemoteDataSourceImpl(instance<SupabaseClient>()));
  }

  if (!GetIt.I.isRegistered<AddAppointmentRepository>()) {
    instance.registerLazySingleton<AddAppointmentRepository>(
        () => AddAppointmentRepositoryImpl(instance()));
  }

  if (!GetIt.I.isRegistered<AddAppointmentUseCase>()) {
    instance.registerFactory<AddAppointmentUseCase>(
        () => AddAppointmentUseCase(instance<AddAppointmentRepository>()));
  }
}

disposeAddAppointmentRequest() {
  if (GetIt.I.isRegistered<AddAppointmentRemoteDataSource>()) {
    instance.unregister<AddAppointmentRemoteDataSource>();
  }

  if (GetIt.I.isRegistered<AddAppointmentRepository>()) {
    instance.unregister<AddAppointmentRepository>();
  }

  if (GetIt.I.isRegistered<AddAppointmentUseCase>()) {
    instance.unregister<AddAppointmentUseCase>();
  }
}

initDoctorAppointments() {
  if (!Get.isRegistered<DoctorAppointmentController>()) {
    Get.put<DoctorAppointmentController>(DoctorAppointmentController());
  }
}

disposeDoctorAppointments() {
  disposeAddAppointmentRequest();
  if (Get.isRegistered<DoctorAppointmentController>()) {
    Get.delete<DoctorAppointmentController>();
  }
}
