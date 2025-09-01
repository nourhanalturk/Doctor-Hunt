import 'package:get/get.dart';
import 'package:tender/config/constants/supabase_fields_constants.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/features/chat/domain/model/chat_with_doctor_model.dart';
import 'package:tender/features/chat/domain/model/doctors_data_model.dart';

import '../../../messages/domain/di/di.dart';
import '../../domain/model/chat_model.dart';

class ChatsController extends GetxController {
  List<ChatModel> allChats = [];
  List<DoctorDataModel> data = [];
  List<int> ids = [];
  List<ChatWithDoctor> combinedChats = [];

  bool isLoading = true;

  getChats() async {
    final userId = supabase.auth.currentUser!.id;
    await supabase
        .from('all_chats')
        .select()
        .eq(SupabaseFieldsConstants.patientId, userId)
        .then(
      (value) {
        allChats = value
            .map(
              (e) => ChatModel.fromJson(e),
            )
            .toList();
        for (var chat in allChats) {
          print(chat.chatId);
          ids.add(chat.doctorId!);
        }
        getDoctorsDetails(ids);
        update();
      },
    ).catchError((e) {
      print(e);
    });
  }

  getDoctorsDetails(List<int> ids) async {
    isLoading = true;
    update();
    if (ids.isEmpty) return;

    final response = await supabase
        .from(SupabaseTableConstants.homeData)
        .select()
        .filter('id', 'in', '(${ids.join(",")})');

    data = response.map((e) => DoctorDataModel.fromJson(e)).toList();

    combinedChats = [];
    for (var chat in allChats) {
      final doctor = data.firstWhere(
        (doc) => doc.doctorId == chat.doctorId,
      );
      combinedChats.add(ChatWithDoctor(chat: chat, doctor: doctor));
    }

    isLoading = false;
    update();
  }

  navigateToMessages(String chatUid, String doctorName) {
    disposeMessages();

    CacheData.setDoctorName(doctorName);
    CacheData.setChatUid(chatUid);
    print(CacheData.getChatUid());
    initMessages();

    Get.toNamed(Routes.messages);
  }

  @override
  void onInit() {
    getChats();
    super.onInit();
  }
}
