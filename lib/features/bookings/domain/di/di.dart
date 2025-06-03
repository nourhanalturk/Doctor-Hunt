import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/features/bookings/presentation/controller/bookings_controller.dart';
import 'package:tender/features/chat/domain/di/di.dart';
import '../../../home/domain/di/di.dart';
import '../../data/data_source/get_appointments_remote_data_source.dart';
import '../../data/repository/get_appointments_repository.dart';
import '../usecase/get_appointments_usecase.dart';
initGetAppointmentsRequest() {
  if (!GetIt.I.isRegistered<GetAppointmentsRemoteDataSource>()) {
    GetIt.I.registerLazySingleton<GetAppointmentsRemoteDataSource>(
            () => GetAppointmentsRemoteDataSourceImpl(GetIt.I<SupabaseClient>()));
  }

  if (!GetIt.I.isRegistered<GetAppointmentsRepository>()) {
    GetIt.I.registerLazySingleton<GetAppointmentsRepository>(
            () => GetAppointmentsRepositoryImpl(GetIt.I(), GetIt.I()));
  }

  if (!GetIt.I.isRegistered<GetAppointmentsUseCase>()) {
    GetIt.I.registerFactory<GetAppointmentsUseCase>(
            () => GetAppointmentsUseCase(GetIt.I<GetAppointmentsRepository>()));
  }
}

disposeGetAppointmentsRequest() {
  if (GetIt.I.isRegistered<GetAppointmentsRemoteDataSource>()) {
    GetIt.I.unregister<GetAppointmentsRemoteDataSource>();
  }

  if (GetIt.I.isRegistered<GetAppointmentsRepository>()) {
    GetIt.I.unregister<GetAppointmentsRepository>();
  }

  if (GetIt.I.isRegistered<GetAppointmentsUseCase>()) {
    GetIt.I.unregister<GetAppointmentsUseCase>();
  }
}

initBookings() {
  disposeHome();
  disposeChats();
  initGetAppointmentsRequest();
  if (!Get.isRegistered<BookingsController>()) {
    Get.put(BookingsController());
  }
}

disposeBooking() {
  disposeGetAppointmentsRequest();
  if (Get.isRegistered<BookingsController>()) {
    Get.delete<BookingsController>();
  }
}
