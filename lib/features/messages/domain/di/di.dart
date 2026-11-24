import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/features/messages/presentation/controller/messages_controller.dart';
import '../../data/data_source/messages_remote_data_source.dart';
import '../../data/repository/messages_repository.dart';
import '../usecase/get_messages_usecase.dart';
import '../usecase/listen_to_new_messages_usecase.dart';
import '../usecase/send_message_usecase.dart';

initMessagesRequest() {
  if (!GetIt.I.isRegistered<MessagesRemoteDataSource>()) {
    instance.registerLazySingleton<MessagesRemoteDataSource>(
      () => MessagesRemoteDataSourceImpl(instance<SupabaseClient>()),
    );
  }

  if (!GetIt.I.isRegistered<MessagesRepository>()) {
    instance.registerLazySingleton<MessagesRepository>(
      () => MessagesRepositoryImpl(instance(), instance()),
    );
  }

  if (!GetIt.I.isRegistered<GetMessagesUseCase>()) {
    instance.registerFactory<GetMessagesUseCase>(
      () => GetMessagesUseCase(instance<MessagesRepository>()),
    );
  }

  if (!GetIt.I.isRegistered<SendMessageUseCase>()) {
    instance.registerFactory<SendMessageUseCase>(
      () => SendMessageUseCase(instance<MessagesRepository>()),
    );
  }

  if (!GetIt.I.isRegistered<ListenToNewMessagesUseCase>()) {
    instance.registerFactory<ListenToNewMessagesUseCase>(
      () => ListenToNewMessagesUseCase(instance<MessagesRepository>()),
    );
  }
}

disposeMessagesRequest() {
  if (GetIt.I.isRegistered<ListenToNewMessagesUseCase>()) {
    instance.unregister<ListenToNewMessagesUseCase>();
  }

  if (GetIt.I.isRegistered<SendMessageUseCase>()) {
    instance.unregister<SendMessageUseCase>();
  }

  if (GetIt.I.isRegistered<GetMessagesUseCase>()) {
    instance.unregister<GetMessagesUseCase>();
  }

  if (GetIt.I.isRegistered<MessagesRepository>()) {
    instance.unregister<MessagesRepository>();
  }

  if (GetIt.I.isRegistered<MessagesRemoteDataSource>()) {
    instance.unregister<MessagesRemoteDataSource>();
  }
}

initMessages() {
  initMessagesRequest();
  if (!Get.isRegistered<MessagesController>()) {
    Get.put<MessagesController>(MessagesController());
  }
}

disposeMessages() {
  disposeMessagesRequest();
  if (Get.isRegistered<MessagesController>()) {
    Get.delete<MessagesController>();
  }
}
