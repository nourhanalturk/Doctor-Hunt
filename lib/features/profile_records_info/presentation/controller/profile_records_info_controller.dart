import 'package:get/get.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/features/profile_records_info/domain/model/patient_model.dart';
import 'package:tender/features/profile_records_info/domain/model/patient_records_model.dart';
import 'package:tender/features/profile_records_info/domain/usecase/get_current_user_id_usecase.dart';
import 'package:tender/features/profile_records_info/domain/usecase/get_patient_info_usecase.dart';
import 'package:tender/features/profile_records_info/domain/usecase/get_patient_records_usecase.dart';

class ProfileRecordsInfoController extends GetxController {
  String userId = "";

  PatientModel patientData =
      PatientModel(fullName: '', contactNumber: '', image: '');

  getUserInfo() async {
    final result = await instance<GetPatientInfoUseCase>().execute(userId);
    result.fold(
      (error) {
        print(error.message);
      },
      (value) {
        patientData = value;
        update();
        print(patientData);
      },
    );
  }

  bool isRecordLoading = true;
  List<PatientRecordsModel> records = [];

  getPatientRecords() async {
    isRecordLoading = true;
    update();

    final result = await instance<GetPatientRecordsUseCase>().execute(userId);
    result.fold(
      (error) {
        isRecordLoading = true;
        update();
        print(error.message);
      },
      (value) {
        records = value;
        print(records);
        isRecordLoading = false;
        update();
      },
    );
  }

  Future<void> _initialize() async {
    final userIdResult = await instance<GetCurrentUserIdUseCase>().execute();
    userId = userIdResult.fold(
      (error) => '',
      (id) => id,
    );

    getUserInfo();
    getPatientRecords();
  }

  @override
  void onInit() {
    super.onInit();
    _initialize();
  }
}
