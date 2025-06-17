import 'package:tender/features/chat/domain/model/chat_model.dart';

import 'doctors_data_model.dart';

class ChatWithDoctor {
  ChatModel chat;
  DoctorDataModel doctor;

  ChatWithDoctor({
    required this.chat,
    required this.doctor,
  });
}
