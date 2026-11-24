import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_state_render_dialog/flutter_state_render_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/storage/local/app_settings_prefs.dart';
import 'package:tender/features/profile/data/request/profile_request.dart';
import 'package:tender/features/profile/data/request/update_patient_request.dart';
import 'package:tender/features/profile/data/request/upload_profile_image_request.dart';
import 'package:tender/features/profile/domain/usecase/get_current_user_id_usecase.dart';
import 'package:tender/features/profile/domain/usecase/profile_usecase.dart';
import 'package:tender/features/profile/domain/usecase/update_patient_usecase.dart';
import 'package:tender/features/profile/domain/usecase/upload_profile_image_usecase.dart';

import '../../../../core/routes/routes.dart';

class ProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  DateTime? pickedDate;
  String userImageUrl = '';
  AppSettingsPrefs prefs = instance<AppSettingsPrefs>();

  Future<void> selectDate(BuildContext context) async {
    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);

      dateOfBirthController.text = formattedDate;
      update();
    }
  }

  profileRequest() async {
    ProfileUsecase usecase = instance<ProfileUsecase>();
    final userIdResult = await instance<GetCurrentUserIdUseCase>().execute();
    final userId = userIdResult.fold(
      (failure) {
        print(failure.message);
        return null;
      },
      (id) => id,
    );
    if (userId == null) return;

    (await usecase.execute(
      ProfileRequest(
        userId: userId,
        imageUrl: imageUrl,
        name: nameController.text,
        contactNumber: contactNumberController.text,
        location: locationController.text,
        dateOfBirth: pickedDate!),
    ))
        .fold(
      (l) {
        print("failed");
      },
      (r) async {
        await updatePatientData();
        Get.snackbar(ManagerStrings.updatedSuccessfully, "");
        Get.toNamed(Routes.mainHome);
      },
    );
  }

  updatePatientData() async {
    final userIdResult = await instance<GetCurrentUserIdUseCase>().execute();
    final userId = userIdResult.fold(
      (failure) {
        print(failure.message);
        return null;
      },
      (id) => id,
    );
    if (userId == null) return;

    final result = await instance<UpdatePatientUseCase>().execute(
      UpdatePatientRequest(
        patientId: userId,
        name: nameController.text,
        contactNumber: contactNumberController.text,
        imageUrl: imageUrl,
      ),
    );

    result.fold(
      (failure) => print(failure.message),
      (_) => null,
    );
  }

  XFile? selectedImage;
  String? uploadedImagePath;
  late String imageUrl;

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    final imageFile = File(image!.path);

    final userIdResult = await instance<GetCurrentUserIdUseCase>().execute();
    final userId = userIdResult.fold(
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
    if (userId == null) return;

    dialogRender(
      context: Get.context!,
      stateRenderType: StateRenderType.popUpLoadingState,
      message: ManagerStrings.uploadingImage,
      title: '',
    );

    final result = await instance<UploadProfileImageUseCase>().execute(
      UploadProfileImageRequest(
        image: imageFile,
        currentImageUrl: imageUrl,
      ),
    );
    Get.back();

    result.fold(
      (failure) {
        dialogRender(
          context: Get.context!,
          stateRenderType: StateRenderType.popUpErrorState,
          message: failure.message,
          title: '',
        );
      },
      (uploadedImage) {
        imageUrl = uploadedImage.url;
        selectedImage = image;
        prefs.setUserImage(imagePath: imageUrl);
        update();
      },
    );
  }

  @override
  void onInit() {
    imageUrl = prefs.getUserImage();
    super.onInit();
  }
}
