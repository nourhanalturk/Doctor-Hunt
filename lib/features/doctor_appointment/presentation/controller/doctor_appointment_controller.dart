import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/core/storage/local/app_settings_prefs.dart';
import 'package:tender/features/doctor_appointment/data/request/appointment_request.dart';

import '../../../../config/constants/constants.dart';
import '../../../../config/constants/supabase_fields_constants.dart';
import '../../../../config/constants/supabase_tables_constants.dart';
import '../../../../core/error_handler/error_handler.dart';
import '../../../../core/helpers/upload_image_helper.dart';
import '../../../../core/internet_checker/internet_checker.dart';
import '../../../../core/internet_checker/is_network_working.dart';
import '../../domain/di/di.dart';
import '../../domain/usecase/appointment_usecase.dart';
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

  onReminderTimesPressed(int index) {
    reminderTimeIndex = index;
    update();
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
    imageUrl = await uploadImage('patient-images',imageFile);
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


    initAddAppointmentRequest();
    AddAppointmentUseCase useCase = instance<AddAppointmentUseCase>();
    AppSettingsPrefs prefs = instance<AppSettingsPrefs>();

    (await useCase.execute(AddAppointmentRequest(
      doctorId: doctorId,
      patientId: prefs.getPatientUid(),
      appointmentTime: appointmentTime,
      contactNumber: contactNumber.text,
      dependentName: patientName.text,
      dependentImageUrl: imageUrl.onNull(),
    ),))
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
       bool isTimeUpdated =await updateTheDoctorAvailableTime();

       if(isTimeUpdated) {
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
       }else{
         updateTheDoctorAvailableTime();
       }

      },
    );
  }

  List<String> availableTimes = [];
  List<DateTime> rawAvailableTimes = [];

  bool isAvailableTimesLoading = false ;
  Future<List<String>> getAvailableTimes({
    required int doctorId,
    required String date,
  }) async {
    isAvailableTimesLoading=true;
    update();
    final response = await Supabase.instance.client
        .from(SupabaseTableConstants.availableTimes)
        .select(SupabaseFieldsConstants.availableTime)
        .eq(SupabaseFieldsConstants.doctorId, doctorId)
        .eq(SupabaseFieldsConstants.availableDate, date);

    rawAvailableTimes = response
        .expand((row) => (row[SupabaseFieldsConstants.availableTime] as List))
        .map((time) => DateTime.parse('$date ${time.toString()}'))
        .toList();

    availableTimes =
        rawAvailableTimes.map((e) => DateFormat('h:mm a').format(e)).toList();
    timeSelected = availableTimes.isNotEmpty ? availableTimes[0] : null;
    isAvailableTimesLoading=false;
    update();

    update();
    return availableTimes;
  }

  updateTheDoctorAvailableTime() async {
    try {
      final currentTimes = await Supabase.instance.client
          .from(SupabaseTableConstants.availableTimes)
          .select(SupabaseFieldsConstants.availableTime)
          .eq(SupabaseFieldsConstants.doctorId, doctorId)
          .eq(SupabaseFieldsConstants.availableDate,
              DateFormat('yyyy-MM-dd').format(selectedDay))
          .single();

      final timeToRemove = DateFormat('HH:mm:ss').format(appointmentTime);

      final updatedTimes =
          (currentTimes[SupabaseFieldsConstants.availableTime] as List)
              .where((time) => time != timeToRemove)
              .toList();

      await Supabase.instance.client
          .from(SupabaseTableConstants.availableTimes)
          .update({SupabaseFieldsConstants.availableTime: updatedTimes})
          .eq(SupabaseFieldsConstants.doctorId, doctorId)
          .eq(SupabaseFieldsConstants.availableDate,
              DateFormat('yyyy-MM-dd').format(selectedDay));
      return true;
    } catch (e) {
      Get.snackbar(
        ManagerStrings.cacheError,
        ManagerStrings.failedToUpdateDoctorsAvailableTime,
        snackPosition: SnackPosition.TOP,
      );
      return false;
    }
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
