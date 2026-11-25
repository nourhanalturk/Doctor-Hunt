import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/routes/routes.dart';
import 'package:tender/features/doctor_details/data/request/doctor_details_request.dart';
import 'package:tender/features/doctor_details/domain/model/sub_home_data_model.dart';
import '../../domain/model/doctor_details_model.dart';
import '../../domain/usecase/create_or_open_chat_usecase.dart';
import '../../domain/usecase/doctor_details_usecase.dart';

class DoctorDetailsController extends GetxController {
  DoctorDetailsModel? details;
  late int doctorId;
  String doctorName = '';
  String doctorSpeciality = '';
  int runningPatients = 0;
  int outgoingPatients = 0;
  int patients = 0;
  String location = '';
  double coastPerHour = 0.0;
  String image = '';
  double rating = 0;
  List<int> values = [];
  List<String> services = [];

  bool isLoading = false;
  bool hasError = false;
  bool isChatLoading = false;
  LatLng coordinates = const LatLng(31.9539, 35.9106);

  /// Safely reads "lat,lng" without ever crashing the details screen.
  LatLng convertLocationString(String? location) {
    if (location == null || location.trim().isEmpty) return coordinates;

    final List<String> parts = location.split(',');
    if (parts.length < 2) return coordinates;

    final double? lat = double.tryParse(parts[0].trim());
    final double? lng = double.tryParse(parts[1].trim());
    if (lat == null || lng == null) return coordinates;
    if (lat < -90 || lat > 90 || lng < -180 || lng > 180) return coordinates;

    return LatLng(lat, lng);
  }

  getDoctorDetails() async {
    isLoading = true;
    hasError = false;
    update();

    final DoctorDetailsUseCase useCase = instance<DoctorDetailsUseCase>();
    final result = await useCase.execute(
      DoctorDetailsRequest(doctorId: CacheData.getDoctorDetailsId()),
    );

    result.fold(
      (failure) {
        hasError = true;
        isLoading = false;
        update();
      },
      (data) {
        details = data;
        final SubHomeDataModel? homeData = data.homeData;

        doctorName = homeData?.name.onNull() ?? '';
        doctorSpeciality = homeData?.speciality.onNull() ?? '';
        rating = homeData?.rating.onNull() ?? 0;
        image = homeData?.image.onNull() ?? '';

        CacheData.setDoctorName(doctorName);
        CacheData.setDoctorSpeciality(doctorSpeciality);
        CacheData.setDoctorRating(rating);
        CacheData.setDoctorImage(image);
        CacheData.setDoctorCoastPerHour(data.coastPerHour.onNull());

        runningPatients = data.runningPatients.onNull();
        outgoingPatients = data.outgoingPatients.onNull();
        patients = data.patients.onNull();
        values = [runningPatients, outgoingPatients, patients];

        coastPerHour = data.coastPerHour.onNull();
        services = List<String>.from(data.services ?? const <String>[]);
        location = data.location;
        coordinates = convertLocationString(data.location);
        hasError = false;
        isLoading = false;
        update();
      },
    );
  }

  retryGetDoctorDetails() => getDoctorDetails();

  List<String> patientStatus = [
    ManagerStrings.running,
    ManagerStrings.ongoing,
    ManagerStrings.patient,
  ];

  navigateToAppointment() {
    if (doctorId == 0) return;
    Get.toNamed(Routes.doctorAppointment);
  }

  createOrOpenChat() async {
    if (doctorId == 0 || isChatLoading) return;

    isChatLoading = true;
    update();

    CreateOrOpenChatUseCase useCase = instance<CreateOrOpenChatUseCase>();
    final result = await useCase.execute(doctorId);

    isChatLoading = false;
    result.fold(
      (failure) {
        Get.snackbar(
          ManagerStrings.tryAgain,
          failure.message,
          snackPosition: SnackPosition.TOP,
        );
        update();
      },
      (chat) {
        CacheData.setDoctorName(doctorName);
        CacheData.setChatUid(chat.chatUid);
        update();
        Get.toNamed(Routes.messages);
      },
    );
  }

  @override
  void onInit() {
    doctorId = CacheData.getDoctorDetailsId();
    getDoctorDetails();
    super.onInit();
  }
}
