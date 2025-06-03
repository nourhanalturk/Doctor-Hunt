import 'package:get/get.dart';
import 'package:tender/config/constants/supabase_fields_constants.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/features/chat/domain/model/doctors_data_model.dart';

import '../../domain/model/chat_model.dart';

class ChatsController extends GetxController {
  List<ChatModel> allChats = [];
  List<DoctorDataModel> data = [];
  List<int> ids = [];

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
    isLoading = false;
    update();
  }

  navigateToMessages(String chatUid, String doctorName){
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
