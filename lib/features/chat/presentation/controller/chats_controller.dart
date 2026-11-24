import 'package:get/get.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/features/chat/domain/model/chat_with_doctor_model.dart';
import 'package:tender/features/chat/domain/model/doctors_data_model.dart';
import 'package:tender/features/chat/domain/usecase/get_chats_usecase.dart';
import 'package:tender/features/chat/domain/usecase/get_doctors_details_usecase.dart';

import '../../domain/model/chat_model.dart';

class ChatsController extends GetxController {
  List<ChatModel> allChats = [];
  List<DoctorDataModel> data = [];
  List<int> ids = [];
  List<ChatWithDoctor> combinedChats = [];

  bool isLoading = true;

  getChats() async {
    GetChatsUseCase useCase = instance<GetChatsUseCase>();
    (await useCase.execute()).fold(
      (l) {
        print(l.message);
      },
      (chats) {
        allChats = chats;
        for (var chat in allChats) {
          print(chat.chatId);
          ids.add(chat.doctorId!);
        }
        getDoctorsDetails(ids);
        update();
      },
    );
  }

  getDoctorsDetails(List<int> ids) async {
    isLoading = true;
    update();
    if (ids.isEmpty) return;

    GetDoctorsDetailsUseCase useCase =
        instance<GetDoctorsDetailsUseCase>();
    (await useCase.execute(ids)).fold(
      (l) {},
      (doctors) {
        data = doctors;

        combinedChats = [];
        for (var chat in allChats) {
          final doctor = data.firstWhere(
            (doc) => doc.doctorId == chat.doctorId,
          );
          combinedChats.add(ChatWithDoctor(chat: chat, doctor: doctor));
        }

        isLoading = false;
        update();
      },
    );
  }

  navigateToMessages(String chatUid, String doctorName) {
    CacheData.setDoctorName(doctorName);
    CacheData.setChatUid(chatUid);
    print(CacheData.getChatUid());

    Get.toNamed(Routes.messages);
  }

  @override
  void onInit() {
    getChats();
    super.onInit();
  }
}
