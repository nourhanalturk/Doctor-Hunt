import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/internet_checker/internet_checker.dart';
import 'package:tender/features/home/domain/di/di.dart';
import 'package:tender/features/profile_records_info/data/data_source/current_user_data_source.dart';
import 'package:tender/features/profile_records_info/data/data_source/patient_records_remote_data_source.dart';
import 'package:tender/features/profile_records_info/data/repository/current_user_repository.dart';
import 'package:tender/features/profile_records_info/data/repository/patient_records_repository.dart';
import 'package:tender/features/profile_records_info/domain/usecase/get_current_user_id_usecase.dart';
import 'package:tender/features/profile_records_info/domain/usecase/get_patient_info_usecase.dart';
import 'package:tender/features/profile_records_info/domain/usecase/get_patient_records_usecase.dart';

import '../../presentation/controller/profile_records_info_controller.dart';

initProfileRecordsInfo() {
  if (!GetIt.I.isRegistered<CurrentUserDataSource>()) {
    instance.registerLazySingleton<CurrentUserDataSource>(
      () => CurrentUserDataSourceImpl(instance<SupabaseClient>()),
    );
  }
  if (!GetIt.I.isRegistered<CurrentUserRepository>()) {
    instance.registerLazySingleton<CurrentUserRepository>(
      () => CurrentUserRepositoryImpl(instance<CurrentUserDataSource>()),
    );
  }
  if (!GetIt.I.isRegistered<GetCurrentUserIdUseCase>()) {
    instance.registerFactory<GetCurrentUserIdUseCase>(
      () => GetCurrentUserIdUseCase(instance<CurrentUserRepository>()),
    );
  }

  if (!GetIt.I.isRegistered<PatientRecordsRemoteDataSource>()) {
    instance.registerLazySingleton<PatientRecordsRemoteDataSource>(
      () => PatientRecordsRemoteDataSourceImpl(instance<SupabaseClient>()),
    );
  }
  if (!GetIt.I.isRegistered<PatientRecordsRepository>()) {
    instance.registerLazySingleton<PatientRecordsRepository>(
      () => PatientRecordsRepositoryImpl(
        instance<PatientRecordsRemoteDataSource>(),
        instance<NetworkInfo>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<GetPatientInfoUseCase>()) {
    instance.registerFactory<GetPatientInfoUseCase>(
      () => GetPatientInfoUseCase(instance<PatientRecordsRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<GetPatientRecordsUseCase>()) {
    instance.registerFactory<GetPatientRecordsUseCase>(
      () => GetPatientRecordsUseCase(instance<PatientRecordsRepository>()),
    );
  }

  if (!Get.isRegistered<ProfileRecordsInfoController>()) {
    Get.put(ProfileRecordsInfoController());
  }
}

disposeProfileRecordsInfo() {
  if (Get.isRegistered<ProfileRecordsInfoController>()) {
    Get.delete<ProfileRecordsInfoController>();
  }

  if (GetIt.I.isRegistered<GetPatientRecordsUseCase>()) {
    instance.unregister<GetPatientRecordsUseCase>();
  }
  if (GetIt.I.isRegistered<GetPatientInfoUseCase>()) {
    instance.unregister<GetPatientInfoUseCase>();
  }
  if (GetIt.I.isRegistered<PatientRecordsRepository>()) {
    instance.unregister<PatientRecordsRepository>();
  }
  if (GetIt.I.isRegistered<PatientRecordsRemoteDataSource>()) {
    instance.unregister<PatientRecordsRemoteDataSource>();
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
