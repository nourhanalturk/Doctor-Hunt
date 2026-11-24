import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/core/storage/local/app_settings_prefs.dart';
import 'package:tender/features/medical_records/data/request/add_medical_record_request.dart';
import 'package:tender/features/medical_records/domain/usecase/add_medical_record_usecase.dart';
import 'package:tender/features/medical_records/domain/usecase/upload_record_image_usecase.dart';

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
    dialogRender(
      context: Get.context!,
      stateRenderType: StateRenderType.popUpLoadingState,
      message: ManagerStrings.uploadingImage,
      title: '',
    );

    final result = await instance<UploadRecordImageUseCase>().execute(image);
    result.fold(
      (failure) {
        if (failure.message == ManagerStrings.noInternetConnection) return;

        dialogRender(
          context: Get.context!,
          stateRenderType: StateRenderType.popUpErrorState,
          message: '${ManagerStrings.failed} ${failure.message}',
          title: '',
        );
      },
      (uploadedImage) {
        imageUrl.add(uploadedImage.url);
        Get.toNamed(Routes.addRecord);
      },
    );
  }

  onUploadFilePressed() async {}

  addRecord() async {
    final result = await instance<AddMedicalRecordUseCase>().execute(
      AddMedicalRecordRequest(
        recordFor: patientNameController.text,
        diseaseName: diseaseNameController.text,
        description: description.text,
        doctorName: doctorName.text,
        medicineNames: medicineNames.text,
        reportDate: convertDateToPostgresFormat(dateController.text),
        imageUrls: imageUrl,
      ),
    );

    result.fold(
      (failure) {
        if (failure.message == ManagerStrings.noInternetConnection) {
          dialogRender(
            context: Get.context!,
            stateRenderType: StateRenderType.popUpErrorState,
            message: ManagerStrings.noInternetConnection,
            title: '',
          );
          return;
        }

        dialogRender(
          context: Get.context!,
          stateRenderType: StateRenderType.popUpErrorState,
          message: '${ManagerStrings.failed} ${failure.message}',
          title: '',
        );
      },
      (_) {
        Get.snackbar(
          ManagerStrings.done,
          ManagerStrings.yourRecordSuccessfullyAdded,
        );
        Get.toNamed(Routes.mainHome);
      },
    );
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
