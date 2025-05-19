import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  DateTime? pickedDate;

  Future<void> selectDate(BuildContext context) async {
    pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
  }
}
