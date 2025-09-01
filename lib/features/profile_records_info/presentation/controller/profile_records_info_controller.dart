import 'package:get/get.dart';
import 'package:tender/config/constants/supabase_fields_constants.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/features/profile_records_info/domain/model/patient_model.dart';
import 'package:tender/features/profile_records_info/domain/model/patient_records_model.dart';

class ProfileRecordsInfoController extends GetxController {
  String userId = "";

  PatientModel patientData =
      PatientModel(fullName: '', contactNumber: '', image: '');

  getUserInfo() async {
    await supabase
        .from(SupabaseTableConstants.patients)
        .select()
        .eq(SupabaseFieldsConstants.patientId, userId)
        .single()
        .then(
      (value) {
        patientData = PatientModel.fromJson(value);
        update();
        print(patientData);
      },
    ).catchError((error) {
      print(error);
    });
  }

  bool isRecordLoading = true;
  List<PatientRecordsModel> records = [];

  getPatientRecords() async {
    isRecordLoading = true;
    update();
    await supabase
        .from(SupabaseTableConstants.medicalRecords)
        .select( )
        .eq(SupabaseFieldsConstants.patientId, userId)
        .then(
      (value) {
        records = value
            .map(
              (e) => PatientRecordsModel.fromJson(e),
            )
            .toList();
        print(records);
        isRecordLoading = false;
        update();
      },
    ).catchError((error) {
      isRecordLoading = true;
      update();
      print(error);
    });
  }

  @override
  void onInit() async {
    userId = supabase.auth.currentUser!.id;
    getUserInfo();
    getPatientRecords();
    super.onInit();
  }
}
