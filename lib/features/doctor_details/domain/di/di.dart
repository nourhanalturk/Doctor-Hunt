import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/features/doctor_details/presentation/controller/doctor_details_controller.dart';
import 'package:tender/features/messages/domain/di/di.dart';
import '../../../../config/di/di.dart';
import '../../data/data_source/create_or_open_chat_remote_data_source.dart';
import '../../data/data_source/doctor_details_remote_data_source.dart';
import '../../data/repository/create_or_open_chat_repository.dart';
import '../../data/repository/doctor_details_repository.dart';
import '../usecase/create_or_open_chat_usecase.dart';
import '../usecase/doctor_details_usecase.dart';

initDoctorDetailsRequest() {
  if (!GetIt.I.isRegistered<DoctorDetailsRemoteDataSource>()) {
    instance.registerLazySingleton<DoctorDetailsRemoteDataSource>(
        () => DoctorDetailsRemoteDataSourceImpl(instance<SupabaseClient>()));
  }

  if (!GetIt.I.isRegistered<DoctorDetailsRepository>()) {
    instance.registerLazySingleton<DoctorDetailsRepository>(
        () => DoctorDetailsRepositoryImpl(instance(), instance()));
  }

  if (!GetIt.I.isRegistered<DoctorDetailsUseCase>()) {
    instance.registerFactory(() => DoctorDetailsUseCase(instance()));
  }

  if (!GetIt.I.isRegistered<CreateOrOpenChatRemoteDataSource>()) {
    instance.registerLazySingleton<CreateOrOpenChatRemoteDataSource>(
      () => CreateOrOpenChatRemoteDataSourceImpl(instance<SupabaseClient>()),
    );
  }

  if (!GetIt.I.isRegistered<CreateOrOpenChatRepository>()) {
    instance.registerLazySingleton<CreateOrOpenChatRepository>(
      () => CreateOrOpenChatRepositoryImpl(instance(), instance()),
    );
  }

  if (!GetIt.I.isRegistered<CreateOrOpenChatUseCase>()) {
    instance.registerFactory<CreateOrOpenChatUseCase>(
      () => CreateOrOpenChatUseCase(instance<CreateOrOpenChatRepository>()),
    );
  }
}

disposeDoctorDetailsRequest() {
  if (GetIt.I.isRegistered<CreateOrOpenChatUseCase>()) {
    instance.unregister<CreateOrOpenChatUseCase>();
  }

  if (GetIt.I.isRegistered<CreateOrOpenChatRepository>()) {
    instance.unregister<CreateOrOpenChatRepository>();
  }

  if (GetIt.I.isRegistered<CreateOrOpenChatRemoteDataSource>()) {
    instance.unregister<CreateOrOpenChatRemoteDataSource>();
  }

  if (GetIt.I.isRegistered<DoctorDetailsRemoteDataSource>()) {
    instance.unregister<DoctorDetailsRemoteDataSource>();
  }

  if (GetIt.I.isRegistered<DoctorDetailsRepository>()) {
    instance.unregister<DoctorDetailsRepository>();
  }

  if (GetIt.I.isRegistered<DoctorDetailsUseCase>()) {
    instance.unregister<DoctorDetailsUseCase>();
  }
}

initDoctorDetails() {
  initDoctorDetailsRequest();
  disposeMessages();

  if (!Get.isRegistered<DoctorDetailsController>()) {}
  Get.put<DoctorDetailsController>(DoctorDetailsController());
}

disposeDoctorDetails() {
  disposeDoctorDetailsRequest();

  if (Get.isRegistered<DoctorDetailsController>()) {}
  Get.delete<DoctorDetailsController>();
}
