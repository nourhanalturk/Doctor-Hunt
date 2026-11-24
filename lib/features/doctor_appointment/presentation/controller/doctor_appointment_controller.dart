import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/core/service/notifications_service.dart';
import 'package:tender/features/doctor_appointment/data/request/appointment_request.dart';

import '../../../../config/constants/constants.dart';
import '../../../../core/helpers/upload_image_helper.dart';
import '../../data/request/get_available_times_request.dart';
import '../../data/request/update_available_time_request.dart';
import '../../domain/usecase/appointment_usecase.dart';
import '../../domain/usecase/get_available_times_usecase.dart';
import '../../domain/usecase/get_current_user_id_usecase.dart';
import '../../domain/usecase/update_available_time_usecase.dart';
import '../view/widget/success_appointment_dialog.dart';

class DoctorAppointmentController extends GetxController {
  TextEditingController patientName = TextEditingController();
  TextEditingController contactNumber = TextEditingController();
  late String doctorName;
  late String doctorSpeciality;
  late String doctorImage;
  late double doctorRating;
  late double doctorCoastPerHour;
  late int doctorId;
  PageController pageController = PageController();
  DateTime focusedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  DateTime appointmentTime = DateTime.now();
  int appointmentTimeSelectedIndex = 0;
  String? timeSelected;
  String? imageUrl;

  List<int> reminderTimes = [30, 40, 25, 10, 35];
  int reminderTimeIndex = 0;

  onReminderTimesPressed(int index, DateTime appointmentTimeReminder) {
    reminderTimeIndex = index;
    setReminderNotification(reminderTimes[index], appointmentTimeReminder);
    update();
  }

  setReminderNotification(
      int reminderMinutesBefore, DateTime appointmentTimeUtc) async {
    await NotiService().initNotification();

    final now = DateTime.now();
    final testTime = now.add(Duration(seconds: 15));

    // 3. Schedule with hardcoded values
    await NotiService().scheduleNotification();

    print('Notification scheduled for ${testTime.toString()}');
  }

  onSelectTime(int index) {
    appointmentTimeSelectedIndex = index;
    timeSelected = availableTimes[index];
    update();
  }

  onFocusDayChanged(DateTime newSelectedDay, DateTime newFocusDate) {
    focusedDay = newFocusDate;
    selectedDay = newSelectedDay;
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);
    getAvailableTimes(doctorId: doctorId, date: formattedDate);
    update();
  }

  onNextPressed() {
    pageController.nextPage(
      duration: const Duration(milliseconds: Constants.outBoardingDurationTime),
      curve: Curves.bounceInOut,
    );
  }

  XFile? selectedImage;
  String? uploadedImagePath;

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    final imageFile = File(image!.path);
    imageUrl = await uploadImage('patient-images', imageFile);
    if (image == null) return;
    if (imageUrl != null) {
      selectedImage = image;
    }
    update();
  }

  addAppointment() async {
    if (timeSelected == null) {
      dialogRender(
        context: Get.context!,
        stateRenderType: StateRenderType.popUpErrorState,
        message: ManagerStrings.youHaveToSelectATime,
        title: '',
      );
      return;
    }

    final userIdResult = await instance<GetCurrentUserIdUseCase>().execute();
    final patientUid = userIdResult.fold(
      (failure) {
        dialogRender(
          context: Get.context!,
          stateRenderType: StateRenderType.popUpErrorState,
          message: failure.message,
          title: '',
        );
        return null;
      },
      (id) => id,
    );

    if (patientUid == null) {
      return;
    }

    AddAppointmentUseCase useCase = instance<AddAppointmentUseCase>();

    (await useCase.execute(
      AddAppointmentRequest(
        doctorId: doctorId,
        patientId: patientUid,
        appointmentTime: appointmentTime,
        contactNumber: contactNumber.text,
        dependentName: patientName.text,
        dependentImageUrl: imageUrl.onNull(),
      ),
    ))
        .fold(
      (l) {
        dialogRender(
          context: Get.context!,
          stateRenderType: StateRenderType.popUpErrorState,
          message: l.message,
          title: '',
        );
      },
      (r) async {
        bool isTimeUpdated = await updateTheDoctorAvailableTime();

        if (isTimeUpdated) {
          Get.dialog(
            successAppointmentDialog(
              doctorName: doctorName,
              appointmentDate:
                  DateFormat('yyyy-MM-dd').format(selectedDay).toString(),
              appointmentTime: timeSelected.onNull(),
              onDonePressed: () {
                Get.toNamed(Routes.mainHome);
              },
              onEditAppointmentPressed: () {
                Get.back();
              },
            ),
          );
        } else {
          updateTheDoctorAvailableTime();
        }
      },
    );
  }

  List<String> availableTimes = [];
  List<DateTime> rawAvailableTimes = [];

  bool isAvailableTimesLoading = false;
  Future<List<String>> getAvailableTimes({
    required int doctorId,
    required String date,
  }) async {
    isAvailableTimesLoading = true;
    update();

    final result = await instance<GetAvailableTimesUseCase>().execute(
      GetAvailableTimesRequest(doctorId: doctorId, date: date),
    );

    result.fold(
      (failure) {
        Get.snackbar(
          ManagerStrings.unexpectedError,
          failure.message,
          snackPosition: SnackPosition.TOP,
        );
      },
      (times) {
        rawAvailableTimes = times.map((time) => time.dateTime).toList();
        availableTimes = rawAvailableTimes
            .map((e) => DateFormat('h:mm a').format(e))
            .toList();
        timeSelected = availableTimes.isNotEmpty ? availableTimes[0] : null;
      },
    );

    isAvailableTimesLoading = false;
    update();
    return availableTimes;
  }

  Future<bool> updateTheDoctorAvailableTime() async {
    final result = await instance<UpdateAvailableTimeUseCase>().execute(
      UpdateAvailableTimeRequest(
        doctorId: doctorId,
        date: DateFormat('yyyy-MM-dd').format(selectedDay),
        timeToRemove: DateFormat('HH:mm:ss').format(appointmentTime),
      ),
    );

    return result.fold(
      (failure) {
        Get.snackbar(
          ManagerStrings.cacheError,
          ManagerStrings.failedToUpdateDoctorsAvailableTime,
          snackPosition: SnackPosition.TOP,
        );
        return false;
      },
      (isUpdated) => isUpdated,
    );
  }

  @override
  void onInit() {
    doctorId = CacheData.doctorDetailsId;
    doctorName = CacheData.getDoctorName();
    doctorSpeciality = CacheData.getDoctorSpeciality();
    doctorImage = CacheData.getDoctorImage();
    doctorRating = CacheData.getDoctorRating();
    doctorCoastPerHour = CacheData.getDoctorCoastPerHour();
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    getAvailableTimes(doctorId: doctorId, date: formattedDate);
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    patientName.dispose();
    contactNumber.dispose();
    selectedImage = null;
    uploadedImagePath = null;
    appointmentTimeSelectedIndex = 0;
    appointmentTime = DateTime.now();
    availableTimes.clear();
    rawAvailableTimes.clear();
    super.onClose();
  }
}
