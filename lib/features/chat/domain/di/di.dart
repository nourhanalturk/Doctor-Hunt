import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/features/chat/presentation/controller/chats_controller.dart';
import 'package:tender/features/home/domain/di/di.dart';
import 'package:tender/features/messages/domain/di/di.dart';

import '../../../bookings/domain/di/di.dart';
import '../../data/data_source/chats_remote_data_source.dart';
import '../../data/repository/chats_repository.dart';
import '../usecase/get_chats_usecase.dart';
import '../usecase/get_doctors_details_usecase.dart';

initChatsRequest() {
  if (!GetIt.I.isRegistered<ChatsRemoteDataSource>()) {
    instance.registerLazySingleton<ChatsRemoteDataSource>(
      () => ChatsRemoteDataSourceImpl(instance<SupabaseClient>()),
    );
  }

  if (!GetIt.I.isRegistered<ChatsRepository>()) {
    instance.registerLazySingleton<ChatsRepository>(
      () => ChatsRepositoryImpl(instance(), instance()),
    );
  }

  if (!GetIt.I.isRegistered<GetChatsUseCase>()) {
    instance.registerFactory<GetChatsUseCase>(
      () => GetChatsUseCase(instance<ChatsRepository>()),
    );
  }

  if (!GetIt.I.isRegistered<GetDoctorsDetailsUseCase>()) {
    instance.registerFactory<GetDoctorsDetailsUseCase>(
      () => GetDoctorsDetailsUseCase(instance<ChatsRepository>()),
    );
  }
}

disposeChatsRequest() {
  if (GetIt.I.isRegistered<GetDoctorsDetailsUseCase>()) {
    instance.unregister<GetDoctorsDetailsUseCase>();
  }

  if (GetIt.I.isRegistered<GetChatsUseCase>()) {
    instance.unregister<GetChatsUseCase>();
  }

  if (GetIt.I.isRegistered<ChatsRepository>()) {
    instance.unregister<ChatsRepository>();
  }

  if (GetIt.I.isRegistered<ChatsRemoteDataSource>()) {
    instance.unregister<ChatsRemoteDataSource>();
  }
}

initChats() {
  disposeHome();
  disposeBooking();
  disposeMessages();
  initChatsRequest();
  if (!Get.isRegistered<ChatsController>()) {
    Get.put<ChatsController>(ChatsController());
  }
}

disposeChats() {
  disposeChatsRequest();
  if (Get.isRegistered<ChatsController>()) {
    Get.delete<ChatsController>();
  }
}
