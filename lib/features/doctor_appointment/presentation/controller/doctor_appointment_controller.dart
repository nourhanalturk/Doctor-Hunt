import 'dart:io';

import 'package:flutter/material.dart';
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
  int appointmentTimeSelectedIndex = -1;
  String? timeSelected;
  String? imageUrl;
  String? uploadedImagePath;

  List<int> reminderTimes = [30, 40, 25, 10, 35];
  int reminderTimeIndex = 0;

  XFile? selectedImage;
  bool isUploadingImage = false;
  bool isSubmitting = false;

  List<String> availableTimes = [];
  List<DateTime> rawAvailableTimes = [];
  bool isAvailableTimesLoading = false;
  String _requestedDate = '';

  void _showError(String message) {
    if (Get.context == null) {
      Get.snackbar(ManagerStrings.tryAgain, message,
          snackPosition: SnackPosition.TOP);
      return;
    }
    dialogRender(
      context: Get.context!,
      stateRenderType: StateRenderType.popUpErrorState,
      message: message,
      title: '',
    );
  }

  /// The reminder is only stored now; it is scheduled after a successful booking.
  onReminderTimesPressed(int index) {
    if (index < 0 || index >= reminderTimes.length) return;
    reminderTimeIndex = index;
    update();
  }

  Future<void> _scheduleReminder() async {
    await NotiService.shared.scheduleAppointmentReminder(
      appointmentTime: appointmentTime,
      minutesBefore: reminderTimes[reminderTimeIndex],
      title: ManagerStrings.appointment,
      body:
          '${ManagerStrings.youBookAnAppointmentWith} $doctorName ${ManagerStrings.at} $timeSelected',
    );
  }

  onSelectTime(int index) {
    if (index < 0 || index >= rawAvailableTimes.length) return;
    appointmentTimeSelectedIndex = index;
    appointmentTime = rawAvailableTimes[index];
    timeSelected = availableTimes[index];
    update();
  }

  onFocusDayChanged(DateTime newSelectedDay, DateTime newFocusDate) {
    final DateTime now = DateTime.now();
    final DateTime startOfToday = DateTime(now.year, now.month, now.day);
    if (newSelectedDay.isBefore(startOfToday)) return;

    focusedDay = newFocusDate;
    selectedDay = newSelectedDay;
    timeSelected = null;
    appointmentTimeSelectedIndex = -1;
    appointmentTime = startOfToday;
    update();

    getAvailableTimes(
      doctorId: doctorId,
      date: DateFormat('yyyy-MM-dd').format(selectedDay),
    );
  }

  onNextPressed() {
    if (!_validatePatientData()) return;
    FocusManager.instance.primaryFocus?.unfocus();
    pageController.nextPage(
      duration: const Duration(milliseconds: Constants.outBoardingDurationTime),
      curve: Curves.easeInOut,
    );
    update();
  }

  onPreviousPressed() {
    if (!pageController.hasClients) return;
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    update();
  }

  bool _validatePatientData() {
    final String name = patientName.text.trim();
    if (name.isEmpty) {
      _showError(ManagerStrings.patientNameRequired);
      return false;
    }

    final String phone = contactNumber.text.trim();
    if (phone.isEmpty) {
      _showError(ManagerStrings.contactNumberRequired);
      return false;
    }
    if (phone.replaceAll(RegExp(r'\D'), '').length < 7) {
      _showError(ManagerStrings.invalidContactNumber);
      return false;
    }
    return true;
  }

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    isUploadingImage = true;
    update();

    final String? uploadedUrl = await uploadImage(
      'patient-images',
      File(image.path),
    );

    isUploadingImage = false;
    if (uploadedUrl != null) {
      selectedImage = image;
      imageUrl = uploadedUrl;
    }
    update();
  }

  addAppointment() async {
    if (isSubmitting) return;

    if (timeSelected == null || availableTimes.isEmpty) {
      _showError(ManagerStrings.youHaveToSelectATime);
      return;
    }
    if (!_validatePatientData()) {
      if (pageController.hasClients) {
        pageController.previousPage(
          duration: const Duration(milliseconds: 320),
          curve: Curves.easeInOut,
        );
      }
      return;
    }

    isSubmitting = true;
    update();

    final userIdResult = await instance<GetCurrentUserIdUseCase>().execute();
    final String? patientUid = userIdResult.fold(
      (failure) {
        _showError(failure.message);
        return null;
      },
      (id) => id,
    );

    if (patientUid == null) {
      isSubmitting = false;
      update();
      return;
    }

    AddAppointmentUseCase useCase = instance<AddAppointmentUseCase>();
    final result = await useCase.execute(
      AddAppointmentRequest(
        doctorId: doctorId,
        patientId: patientUid,
        appointmentTime: appointmentTime,
        contactNumber: contactNumber.text.trim(),
        dependentName: patientName.text.trim(),
        dependentImageUrl: imageUrl.onNull(),
      ),
    );

    result.fold(
      (failure) {
        isSubmitting = false;
        update();
        _showError(failure.message);
      },
      (r) async {
        final bool isTimeUpdated = await updateTheDoctorAvailableTime();
        await _scheduleReminder();

        isSubmitting = false;
        update();

        if (!isTimeUpdated) {
          Get.snackbar(
            ManagerStrings.cacheError,
            ManagerStrings.slotSyncError,
            snackPosition: SnackPosition.TOP,
          );
        }

        Get.dialog(
          successAppointmentDialog(
            doctorName: doctorName,
            appointmentDate: DateFormat('yyyy-MM-dd').format(selectedDay),
            appointmentTime: timeSelected.onNull(),
            onDonePressed: finishBooking,
            onEditAppointmentPressed: () => Get.back(),
          ),
        );
      },
    );
  }

  void finishBooking() {
    Get.back();
    if (Get.isRegistered<DoctorAppointmentController>()) {
      Get.delete<DoctorAppointmentController>();
    }
    Get.offAllNamed(Routes.mainHome);
  }

  getAvailableTimes({
    required int doctorId,
    required String date,
  }) async {
    _requestedDate = date;
    isAvailableTimesLoading = true;
    availableTimes = [];
    rawAvailableTimes = [];
    timeSelected = null;
    appointmentTimeSelectedIndex = -1;
    update();

    final result = await instance<GetAvailableTimesUseCase>().execute(
      GetAvailableTimesRequest(doctorId: doctorId, date: date),
    );

    if (_requestedDate != date) return;

    result.fold(
      (failure) {
        Get.snackbar(
          ManagerStrings.unexpectedError,
          failure.message,
          snackPosition: SnackPosition.TOP,
        );
      },
      (times) {
        final DateTime now = DateTime.now();
        rawAvailableTimes = times
            .map((time) => time.dateTime)
            .where((time) => time.isAfter(now))
            .toList();
        availableTimes = rawAvailableTimes
            .map((e) => DateFormat('h:mm a').format(e))
            .toList();
        if (rawAvailableTimes.isNotEmpty) {
          appointmentTime = rawAvailableTimes.first;
          timeSelected = availableTimes.first;
          appointmentTimeSelectedIndex = 0;
        }
      },
    );

    isAvailableTimesLoading = false;
    update();
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
      (failure) => false,
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

    final DateTime now = DateTime.now();
    selectedDay = DateTime(now.year, now.month, now.day);
    focusedDay = selectedDay;
    appointmentTime = selectedDay;
    getAvailableTimes(
      doctorId: doctorId,
      date: DateFormat('yyyy-MM-dd').format(selectedDay),
    );
    super.onInit();
  }

  @override
  void onClose() {
    pageController.dispose();
    patientName.dispose();
    contactNumber.dispose();
    selectedImage = null;
    uploadedImagePath = null;
    appointmentTimeSelectedIndex = -1;
    timeSelected = null;
    isSubmitting = false;
    isUploadingImage = false;
    availableTimes.clear();
    rawAvailableTimes.clear();
    super.onClose();
  }
}
