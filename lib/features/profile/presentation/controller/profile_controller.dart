import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/storage/local/app_settings_prefs.dart';
import 'package:tender/features/profile/data/request/profile_request.dart';
import 'package:tender/features/profile/domain/usecase/profile_usecase.dart';

import '../../../../config/constants/supabase_fields_constants.dart';
import '../../../../core/helpers/upload_image_helper.dart';
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
    final userId = supabase.auth.currentUser!.id;
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
      (r) async{
       await updatePatientData();
       Get.snackbar(ManagerStrings.updatedSuccessfully, "");
       Get.toNamed(Routes.mainHome);
      },
    );
  }

  updatePatientData() async {
    final userId = supabase.auth.currentUser!.id;

    await supabase
        .from(SupabaseTableConstants.patients)
        .update({
          SupabaseFieldsConstants.fullName: nameController.text,
          SupabaseFieldsConstants.contactNumber: contactNumberController.text,
          SupabaseFieldsConstants.profileImageUrl: imageUrl,
        })
        .eq('patient_id', userId)
        .then(
          (value) {
            print(value);
          },
        )
        .catchError((e) {
          print(e);
        });
  }

  XFile? selectedImage;
  String? uploadedImagePath;
  late String imageUrl;

  pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    final imageFile = File(image!.path);

    const bucketName = 'profile-image';

    final currentImageUrl = imageUrl;
    if (currentImageUrl != null && currentImageUrl.isNotEmpty) {
      try {
        final uri = Uri.parse(currentImageUrl);
        final fullPath = uri.pathSegments
            .skipWhile((s) => s != bucketName)
            .skip(1)
            .join('/');

        await supabase.storage.from(bucketName).remove([fullPath]);
        print('Previous image removed: $fullPath');
      } catch (e) {
        print('Failed to remove previous image: $e');
      }
    }

    imageUrl = (await uploadImage(bucketName, imageFile))!;
    if (image == null) return;
    if (imageUrl != null) {
      selectedImage = image;
      prefs.setUserImage(imagePath: imageUrl);
    }
    update();
  }

  @override
  void onInit() {
    imageUrl = prefs.getUserImage();
    super.onInit();
  }
}
