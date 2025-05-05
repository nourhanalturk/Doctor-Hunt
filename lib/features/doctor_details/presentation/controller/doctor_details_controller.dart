import 'package:get/get.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/features/doctor_details/data/request/doctor_details_request.dart';
import 'package:tender/features/doctor_details/domain/model/sub_home_data_model.dart';
import '../../domain/model/doctor_details_model.dart';
import '../../domain/usecase/doctor_details_usecase.dart';

class DoctorDetailsController extends GetxController {
  DoctorDetailsModel? details;
  late int doctorId;
  String doctorName ='';
  String doctorSpeciality ='';
  int runningPatients =0;
  int outgoingPatients =0;
  int patients =0;
  String location ='';
  double coastPerHour =0.0;
  String image ='';
  double rating =0;
  List<int> values = [];
  List<String> services =[];

  bool isLoading = false;

  getDoctorDetails() async {
    isLoading =true;
    update();
    final DoctorDetailsUseCase useCase = instance<DoctorDetailsUseCase>();

    (await useCase.execute(DoctorDetailsRequest(doctorId: CacheData.getDoctorDetailsId()))).fold(
      (l) {
        isLoading =false;
        update();

      },
      (data) {
        details = data;
        SubHomeDataModel? homeData = data.homeData;
        doctorName =homeData!.name.onNull();
        doctorSpeciality = homeData.speciality.onNull();
        rating = homeData.rating.onNull();
        image= homeData.image.onNull();

        runningPatients = data.runningPatients.onNull();
        outgoingPatients = data.outgoingPatients.onNull();
        patients =data.patients.onNull();

        values = [runningPatients,outgoingPatients ,patients];
        coastPerHour =data.coastPerHour.onNull();
        services =data.services!;
        isLoading =false;
        update();
      },
    );
  }

  List<String> patientStatus = [
    ManagerStrings.running,
    ManagerStrings.ongoing,
    ManagerStrings.patient,
  ];


  navigateToAppointment(){
    Get.toNamed(Routes.doctorAppointment);
  }

  @override
  void onInit() {
    doctorId = CacheData.getDoctorDetailsId();
    getDoctorDetails();
    super.onInit();
  }
}
