import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/features/my_doctors/presentation/controller/my_doctors_controller.dart';
import '../../data/data_source/my_doctors_remote_data_source.dart';
import '../../data/repository/my_doctors_repository.dart';
import '../usecase/get_my_doctors_details_usecase.dart';
import '../usecase/get_my_doctors_usecase.dart';

initMyDoctorsRequest() {
  if (!GetIt.I.isRegistered<MyDoctorsRemoteDataSource>()) {
    instance.registerLazySingleton<MyDoctorsRemoteDataSource>(
      () => MyDoctorsRemoteDataSourceImpl(instance<SupabaseClient>()),
    );
  }

  if (!GetIt.I.isRegistered<MyDoctorsRepository>()) {
    instance.registerLazySingleton<MyDoctorsRepository>(
      () => MyDoctorsRepositoryImpl(instance(), instance()),
    );
  }

  if (!GetIt.I.isRegistered<GetMyDoctorsUseCase>()) {
    instance.registerFactory<GetMyDoctorsUseCase>(
      () => GetMyDoctorsUseCase(instance<MyDoctorsRepository>()),
    );
  }

  if (!GetIt.I.isRegistered<GetMyDoctorsDetailsUseCase>()) {
    instance.registerFactory<GetMyDoctorsDetailsUseCase>(
      () => GetMyDoctorsDetailsUseCase(instance<MyDoctorsRepository>()),
    );
  }
}

disposeMyDoctorsRequest() {
  if (GetIt.I.isRegistered<GetMyDoctorsDetailsUseCase>()) {
    instance.unregister<GetMyDoctorsDetailsUseCase>();
  }

  if (GetIt.I.isRegistered<GetMyDoctorsUseCase>()) {
    instance.unregister<GetMyDoctorsUseCase>();
  }

  if (GetIt.I.isRegistered<MyDoctorsRepository>()) {
    instance.unregister<MyDoctorsRepository>();
  }

  if (GetIt.I.isRegistered<MyDoctorsRemoteDataSource>()) {
    instance.unregister<MyDoctorsRemoteDataSource>();
  }
}

initMyDoctors() {
  initMyDoctorsRequest();
  if (!Get.isRegistered<MyDoctorsController>()) {
    Get.put<MyDoctorsController>(MyDoctorsController());
  }
}

disposeMyDoctors() {
  disposeMyDoctorsRequest();
  if (Get.isRegistered<MyDoctorsController>()) {
    Get.delete<MyDoctorsController>();
  }
}
