import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/features/home/data/repository/home_data_repository.dart';
import 'package:tender/features/register/presentation/controller/register_controller.dart';
import '../../../../config/di/di.dart';
import '../../../login/domain/di/di.dart';
import '../../../splash/domain/di.dart';
import '../../data/data_source/add_patient_remote_data_source.dart';
import '../../data/repo/add_patient_repository.dart';
import '../usecase/add_patient_usecase.dart';

initAddPatientRequest() {
  if (!GetIt.I.isRegistered<AddPatientRemoteDataSource>()) {
    instance.registerLazySingleton<AddPatientRemoteDataSource>(
            () => AddPatientRemoteDataSourceImpl(instance<SupabaseClient>()));
  }

  if (!GetIt.I.isRegistered<AddPatientRepository>()) {
    instance.registerLazySingleton<AddPatientRepository>(
            () => AddPatientRepositoryImpl(instance()));
  }

  if (!GetIt.I.isRegistered<AddPatientUseCase>()) {
    instance.registerFactory<AddPatientUseCase>(
            () => AddPatientUseCase(instance<AddPatientRepository>()));
  }
}

disposeAddPatientRequest() {
  if (GetIt.I.isRegistered<AddPatientRemoteDataSource>()) {
    instance.unregister<AddPatientRemoteDataSource>();
  }

  if (GetIt.I.isRegistered<AddPatientRepository>()) {
    instance.unregister<AddPatientRepository>();
  }

  if (GetIt.I.isRegistered<AddPatientUseCase>()) {
    instance.unregister<AddPatientUseCase>();
  }
}
initRegister() {
  disposeLogin();
  disposeSplash();
  disposeLogin();
  if (!Get.isRegistered<RegisterController>()) {
    Get.put<RegisterController>(RegisterController());
  }
}

disposeRegister() {
  disposeAddPatientRequest();
  if (Get.isRegistered<RegisterController>()) {
    Get.delete<RegisterController>();
  }
}
