import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/core/storage/local/app_settings_prefs.dart';
import 'package:tender/features/medical_records/domain/model/type_of_records_model.dart';

class MedicalRecordsController extends GetxController {
  List medicalRecords = [];
  AppSettingsPrefs prefs = instance<AppSettingsPrefs>();
  TextEditingController patientNameController = TextEditingController();

  List<XFile>? selectedImage = [];

  String? patientName;

  List<TypeOfRecordModel> recordTypes = [
    TypeOfRecordModel(
      icon: ManagerImages.camera,
      title: ManagerStrings.report,
    ),
    TypeOfRecordModel(
      icon: ManagerImages.camera,
      title: ManagerStrings.prescription,
    ),
    TypeOfRecordModel(
      icon: ManagerImages.camera,
      title: ManagerStrings.invoice,
    ),
  ];

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
    update();
    Get.toNamed(Routes.addRecord);
  }

  onUploadFilePressed() async {}

  @override
  void onInit() {
    patientName = prefs.getPatientName();
    super.onInit();
  }
}
