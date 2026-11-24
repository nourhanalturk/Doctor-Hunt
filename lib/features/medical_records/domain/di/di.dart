import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/internet_checker/internet_checker.dart';
import 'package:tender/features/medical_records/data/data_source/medical_records_remote_data_source.dart';
import 'package:tender/features/medical_records/data/repository/medical_records_repository.dart';
import 'package:tender/features/medical_records/domain/usecase/add_medical_record_usecase.dart';
import 'package:tender/features/medical_records/domain/usecase/upload_record_image_usecase.dart';
import 'package:tender/features/medical_records/presentation/controller/medical_records_controller.dart';

initMedicalRecords() {
  if (!GetIt.I.isRegistered<MedicalRecordsRemoteDataSource>()) {
    instance.registerLazySingleton<MedicalRecordsRemoteDataSource>(
      () => MedicalRecordsRemoteDataSourceImpl(instance<SupabaseClient>()),
    );
  }
  if (!GetIt.I.isRegistered<MedicalRecordsRepository>()) {
    instance.registerLazySingleton<MedicalRecordsRepository>(
      () => MedicalRecordsRepositoryImpl(
        instance<MedicalRecordsRemoteDataSource>(),
        instance<NetworkInfo>(),
      ),
    );
  }
  if (!GetIt.I.isRegistered<UploadRecordImageUseCase>()) {
    instance.registerFactory<UploadRecordImageUseCase>(
      () => UploadRecordImageUseCase(instance<MedicalRecordsRepository>()),
    );
  }
  if (!GetIt.I.isRegistered<AddMedicalRecordUseCase>()) {
    instance.registerFactory<AddMedicalRecordUseCase>(
      () => AddMedicalRecordUseCase(instance<MedicalRecordsRepository>()),
    );
  }

  if (!Get.isRegistered<MedicalRecordsController>()) {
    Get.put<MedicalRecordsController>(MedicalRecordsController());
  }
}

disposeMedicalRecords() {
  if (Get.isRegistered<MedicalRecordsController>()) {
    Get.delete<MedicalRecordsController>();
  }

  if (GetIt.I.isRegistered<AddMedicalRecordUseCase>()) {
    instance.unregister<AddMedicalRecordUseCase>();
  }
  if (GetIt.I.isRegistered<UploadRecordImageUseCase>()) {
    instance.unregister<UploadRecordImageUseCase>();
  }
  if (GetIt.I.isRegistered<MedicalRecordsRepository>()) {
    instance.unregister<MedicalRecordsRepository>();
  }
  if (GetIt.I.isRegistered<MedicalRecordsRemoteDataSource>()) {
    instance.unregister<MedicalRecordsRemoteDataSource>();
  }
}
