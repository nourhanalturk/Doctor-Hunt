import '../../domain/model/chat_model.dart';
import '../../domain/model/doctors_data_model.dart';
import '../response/chat_response.dart';
import '../response/doctor_data_response.dart';

extension ChatMapper on ChatResponse {
  ChatModel toDomain() => ChatModel(
        chatId: chatId,
        doctorId: doctorId,
        patientId: patientId,
        lastMessage: lastMessage,
        updatedAt: updatedAt,
      );
}

extension DoctorDataMapper on DoctorDataResponse {
  DoctorDataModel toDomain() => DoctorDataModel(
        doctorId: doctorId,
        doctorName: doctorName,
        image: image,
      );
}
