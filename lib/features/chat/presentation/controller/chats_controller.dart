import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/features/chat/domain/model/chat_model.dart';
import 'package:tender/features/chat/domain/model/chat_with_doctor_model.dart';
import 'package:tender/features/chat/domain/model/doctors_data_model.dart';
import 'package:tender/features/chat/domain/usecase/get_chats_usecase.dart';
import 'package:tender/features/chat/domain/usecase/get_doctors_details_usecase.dart';

class ChatsController extends GetxController {
  List<ChatModel> allChats = [];
  List<DoctorDataModel> data = [];
  List<int> ids = [];
  List<ChatWithDoctor> combinedChats = [];

  bool isLoading = true;

  getChats() async {
    isLoading = true;
    update();

    GetChatsUseCase useCase = instance<GetChatsUseCase>();
    (await useCase.execute()).fold(
      (failure) {
        allChats = [];
        ids = [];
        combinedChats = [];
        isLoading = false;
        update();
      },
      (chats) {
        allChats = chats;
        ids = chats
            .where((chat) => chat.doctorId != null)
            .map((chat) => chat.doctorId!)
            .toList();

        if (ids.isEmpty) {
          combinedChats = [];
          isLoading = false;
          update();
          return;
        }

        getDoctorsDetails(List<int>.from(ids));
      },
    );
  }

  getDoctorsDetails(List<int> ids) async {
    isLoading = true;
    update();

    if (ids.isEmpty) {
      isLoading = false;
      update();
      return;
    }

    GetDoctorsDetailsUseCase useCase = instance<GetDoctorsDetailsUseCase>();
    (await useCase.execute(ids)).fold(
      (failure) {
        isLoading = false;
        update();
      },
      (doctors) {
        data = doctors;
        final Map<int, DoctorDataModel> doctorsById = {
          for (final doctor in doctors)
            if (doctor.doctorId != null) doctor.doctorId!: doctor,
        };

        combinedChats = allChats
            .where(
              (chat) =>
                  chat.doctorId != null && doctorsById.containsKey(chat.doctorId),
            )
            .map(
              (chat) => ChatWithDoctor(
                chat: chat,
                doctor: doctorsById[chat.doctorId]!,
              ),
            )
            .toList()
          ..sort(
            (a, b) => _chatTime(b.chat).compareTo(_chatTime(a.chat)),
          );

        isLoading = false;
        update();
      },
    );
  }

  DateTime _chatTime(ChatModel chat) =>
      DateTime.tryParse(chat.updatedAt ?? '') ??
      DateTime.fromMillisecondsSinceEpoch(0);

  String formatChatTime(String? updatedAt) {
    final DateTime? time = DateTime.tryParse(updatedAt ?? '');
    if (time == null) return '';

    final DateTime now = DateTime.now();
    final bool isToday = time.year == now.year &&
        time.month == now.month &&
        time.day == now.day;

    return isToday ? DateFormat.Hm().format(time) : DateFormat('d MMM').format(time);
  }

  navigateToMessages(String chatUid, String doctorName) {
    CacheData.setDoctorName(doctorName);
    CacheData.setChatUid(chatUid);
    Get.toNamed(Routes.messages);
  }

  @override
  void onInit() {
    getChats();
    super.onInit();
  }
}
