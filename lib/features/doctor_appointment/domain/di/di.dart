import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../config/di/di.dart';
import '../../data/data_source/appointment.dart';
import '../../data/data_source/available_times_remote_data_source.dart';
import '../../data/data_source/current_user_data_source.dart';
import '../../data/repository/appointment_repository.dart';
import '../../data/repository/available_times_repository.dart';
import '../../data/repository/current_user_repository.dart';
import '../../presentation/controller/doctor_appointment_controller.dart';
import '../usecase/appointment_usecase.dart';
import '../usecase/get_available_times_usecase.dart';
import '../usecase/get_current_user_id_usecase.dart';
import '../usecase/update_available_time_usecase.dart';

initAddAppointmentRequest() {
  if (!GetIt.I.isRegistered<AddAppointmentRemoteDataSource>()) {
    instance.registerLazySingleton<AddAppointmentRemoteDataSource>(
        () => AddAppointmentRemoteDataSourceImpl(instance<SupabaseClient>()));
  }

  if (!GetIt.I.isRegistered<AddAppointmentRepository>()) {
    instance.registerLazySingleton<AddAppointmentRepository>(
        () => AddAppointmentRepositoryImpl(instance(), instance()));
  }

  if (!GetIt.I.isRegistered<AddAppointmentUseCase>()) {
    instance.registerFactory<AddAppointmentUseCase>(
        () => AddAppointmentUseCase(instance<AddAppointmentRepository>()));
  }

  if (!GetIt.I.isRegistered<AvailableTimesRemoteDataSource>()) {
    instance.registerLazySingleton<AvailableTimesRemoteDataSource>(
        () => AvailableTimesRemoteDataSourceImpl(instance<SupabaseClient>()));
  }

  if (!GetIt.I.isRegistered<AvailableTimesRepository>()) {
    instance.registerLazySingleton<AvailableTimesRepository>(
        () => AvailableTimesRepositoryImpl(instance(), instance()));
  }

  if (!GetIt.I.isRegistered<GetAvailableTimesUseCase>()) {
    instance.registerFactory<GetAvailableTimesUseCase>(
        () => GetAvailableTimesUseCase(instance<AvailableTimesRepository>()));
  }

  if (!GetIt.I.isRegistered<UpdateAvailableTimeUseCase>()) {
    instance.registerFactory<UpdateAvailableTimeUseCase>(
        () => UpdateAvailableTimeUseCase(instance<AvailableTimesRepository>()));
  }

  if (!GetIt.I.isRegistered<CurrentUserDataSource>()) {
    instance.registerLazySingleton<CurrentUserDataSource>(
        () => CurrentUserDataSourceImpl(instance<SupabaseClient>()));
  }

  if (!GetIt.I.isRegistered<CurrentUserRepository>()) {
    instance.registerLazySingleton<CurrentUserRepository>(
        () => CurrentUserRepositoryImpl(instance<CurrentUserDataSource>()));
  }

  if (!GetIt.I.isRegistered<GetCurrentUserIdUseCase>()) {
    instance.registerFactory<GetCurrentUserIdUseCase>(
        () => GetCurrentUserIdUseCase(instance<CurrentUserRepository>()));
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

  if (GetIt.I.isRegistered<GetAvailableTimesUseCase>()) {
    instance.unregister<GetAvailableTimesUseCase>();
  }

  if (GetIt.I.isRegistered<UpdateAvailableTimeUseCase>()) {
    instance.unregister<UpdateAvailableTimeUseCase>();
  }

  if (GetIt.I.isRegistered<AvailableTimesRepository>()) {
    instance.unregister<AvailableTimesRepository>();
  }

  if (GetIt.I.isRegistered<AvailableTimesRemoteDataSource>()) {
    instance.unregister<AvailableTimesRemoteDataSource>();
  }

  if (GetIt.I.isRegistered<GetCurrentUserIdUseCase>()) {
    instance.unregister<GetCurrentUserIdUseCase>();
  }

  if (GetIt.I.isRegistered<CurrentUserRepository>()) {
    instance.unregister<CurrentUserRepository>();
  }

  if (GetIt.I.isRegistered<CurrentUserDataSource>()) {
    instance.unregister<CurrentUserDataSource>();
  }
}

initDoctorAppointments() {
  initAddAppointmentRequest();
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
