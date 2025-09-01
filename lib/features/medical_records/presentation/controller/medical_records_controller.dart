import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/internet_checker/internet_checker.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/core/storage/local/app_settings_prefs.dart';
import '../../../../config/constants/supabase_fields_constants.dart';
import '../../../../core/validator/validator.dart';

class MedicalRecordsController extends GetxController {
  List medicalRecords = [];
  AppSettingsPrefs prefs = instance<AppSettingsPrefs>();

  TextEditingController patientNameController = TextEditingController();
  TextEditingController diseaseNameController = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController doctorName = TextEditingController();
  TextEditingController medicineNames = TextEditingController();
  TextEditingController dateController = TextEditingController();

  List<String> imageUrl = [];
  FieldValidator validator = FieldValidator();

  List<XFile>? selectedImage = [];

  String? patientName;

  int selectedRecordIndex = 0;

  changeSelectedRecordType(int index) {
    selectedRecordIndex = index;
    update();
  }

  changePatientName() {
    patientName = patientNameController.text;
    update();
  }

  onTakePhotoPressed(int index) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    selectedImage?.add(image);
    File imageFile = File(image.path);
    uploadImage(imageFile);
    update();
    if (index == 0) {
      Get.toNamed(Routes.addRecord);
    }
  }

  onUploadFromGalleryPressed() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    selectedImage?.add(image);

    final imageFile = File(image.path);
    await uploadImage(imageFile);
    update();
  }

  uploadImage(File image) async {
    NetworkInfo networkInfo = instance<NetworkInfo>();
    dialogRender(
      context: Get.context!,
      stateRenderType: StateRenderType.popUpLoadingState,
      message: ManagerStrings.uploadingImage,
      title: '',
    );

    if (await networkInfo.isConnected) {
      final fileName = DateTime.now().microsecondsSinceEpoch.toString();
      final userId = supabase.auth.currentUser!.id;
      final path = '$userId/$fileName';
      await supabase.storage
          .from(SupabaseTableConstants.records)
          .upload(path, image)
          .then(
        (value) {
          final url = supabase.storage
              .from(SupabaseTableConstants.records)
              .getPublicUrl(path);
          imageUrl.add(url);
          Get.toNamed(Routes.addRecord);
        },
      ).catchError((e) {
        print(e);

        dialogRender(
          context: Get.context!,
          stateRenderType: StateRenderType.popUpErrorState,
          message: '${ManagerStrings.failed} $e',
          title: '',
        );
      });
    }
  }

  onUploadFilePressed() async {}

  addRecord() async {
    NetworkInfo networkInfo = instance<NetworkInfo>();
    if (await networkInfo.isConnected) {
      final patientId = supabase.auth.currentUser!.id;

      await supabase.from(SupabaseTableConstants.medicalRecords).insert({
        SupabaseFieldsConstants.recordFor: patientNameController.text,
        SupabaseFieldsConstants.patientId: patientId,
        SupabaseFieldsConstants.diseaseName: diseaseNameController.text,
        SupabaseFieldsConstants.description: description.text,
        SupabaseFieldsConstants.doctorName: doctorName.text,
        SupabaseFieldsConstants.medicineNames: medicineNames.text,
        SupabaseFieldsConstants.reportDate:convertDateToPostgresFormat(dateController.text),
        SupabaseFieldsConstants.imageUrls: imageUrl,
      }).then(
        (value) {
          Get.snackbar(ManagerStrings.done, ManagerStrings.yourRecordSuccessfullyAdded);
          Get.toNamed(Routes.mainHome);
          print('added');
        },
      ).catchError((e) {
        print(e);
        dialogRender(
          context: Get.context!,
          stateRenderType: StateRenderType.popUpErrorState,
          message: '${ManagerStrings.failed} $e',
          title: '',
        );
      });
    } else {

      dialogRender(
          context: Get.context!,
          stateRenderType: StateRenderType.popUpErrorState,
          message: ManagerStrings.noInternetConnection,
          title: '');
    }
  }
  String convertDateToPostgresFormat(String input) {
    try {
      final parts = input.split('/');
      if (parts.length != 3) return input;

      final day = parts[0].padLeft(2, '0');
      final month = parts[1].padLeft(2, '0');
      final year = parts[2];

      return '$year-$month-$day'; // YYYY-MM-DD
    } catch (e) {
      return input; // fallback
    }
  }
  @override
  void onInit() {
    patientName = prefs.getPatientName();
    super.onInit();
  }
}
