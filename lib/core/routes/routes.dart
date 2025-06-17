import 'package:flutter/material.dart';
import 'package:tender/features/bookings/domain/di/di.dart';
import 'package:tender/features/bookings/presentation/view/bookings_view.dart';
import 'package:tender/features/chat/domain/di/di.dart';
import 'package:tender/features/doctor_details/domain/di/di.dart';
import 'package:tender/features/doctor_details/presentation/view/doctor_details_view.dart';
import 'package:tender/features/health-checkups/domain/di/di.dart';
import 'package:tender/features/health-checkups/presentation/view/health_checkups_view.dart';
import 'package:tender/features/login/domain/di/di.dart';
import 'package:tender/features/login/presentation/view/login_view.dart';
import 'package:tender/features/main_container/domain/di/di.dart';
import 'package:tender/features/main_container/presentation/view/main_container_view.dart';
import 'package:tender/features/main_home/domain/di/di.dart';
import 'package:tender/features/main_home/presentation/view/main_home_view.dart';
import 'package:tender/features/medical_records/domain/di/di.dart';
import 'package:tender/features/medical_records/presentation/view/add_medical_record_view.dart';
import 'package:tender/features/medical_records/presentation/view/medical_records_view.dart';
import 'package:tender/features/my_doctors/domain/di/di.dart';
import 'package:tender/features/my_doctors/presentation/view/my_doctors_view.dart';
import 'package:tender/features/out_boarding/presentation/view/out_boarding_view.dart';
import 'package:tender/features/popular_doctor/presentation/view/popular_doctors_view.dart';
import 'package:tender/features/privacy_and_policy/domain/di/di.dart';
import 'package:tender/features/privacy_and_policy/presentation/view/privacy_and_policy_view.dart';
import 'package:tender/features/profile/domain/di/di.dart';
import 'package:tender/features/profile/presentation/view/profile_view.dart';
import 'package:tender/features/register/domain/di/di.dart';
import 'package:tender/features/register/presentation/view/register_view.dart';
import 'package:tender/features/settings/domain/di/di.dart';
import 'package:tender/features/settings/presentation/view/settings_view.dart';
import 'package:tender/features/splash/domain/di.dart';
import 'package:tender/features/splash/presentation/view/splash_view.dart';
import '../../features/chat/presentation/view/chats_view.dart';
import '../../features/doctor_appointment/domain/di/di.dart';
import '../../features/doctor_appointment/presentation/view/appointment_view.dart';
import '../../features/home/domain/di/di.dart';
import '../../features/home/presentation/view/home_view.dart';
import '../../features/medicine_orders/domain/di/di.dart';
import '../../features/medicine_orders/presentation/view/medicine_orders_view.dart';
import '../../features/messages/domain/di/di.dart';
import '../../features/messages/presentation/view/messages_view.dart';
import '../../features/out_boarding/domain/di.dart';
import '../../features/popular_doctor/domain/di/di.dart';
import '../resources/manager_strings.dart';

/// A class defined for all routes constants
class Routes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String outBoarding = '/outBoarding';
  static const String mainHome = '/mainHome';
  static const String home = '/home';
  static const String doctorDetails = '/doctorDetails';
  static const String doctorAppointment = '/doctorAppointment';
  static const String popularDoctors = '/popularDoctors';
  static const String profile = '/profile';
  static const String medicalRecords = '/medicalRecords';
  static const String addRecord = '/addRecord';
  static const String chats = '/chats';
  static const String messages = '/messages';
  static const String mainContainer = '/mainContainer';
  static const String medicalOrders = '/medicalOrders';
  static const String settings = '/settings';
  static const String bookings = '/bookings';
  static const String healthCheckups = '/healthCheckups';
  static const String myDoctors = '/myDoctors';
  static const String privacyAndPolicy = '/privacyAndPolicy';

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.login:
        initLogin();
        return MaterialPageRoute(
          builder: (context) => const LoginView(),
        );
      case Routes.register:
        initRegister();
        return MaterialPageRoute(
          builder: (context) => const RegisterView(),
        );
      case Routes.splash:
        initSplash();
        return MaterialPageRoute(
          builder: (context) => const SplashView(),
        );
      case Routes.outBoarding:
        initOutBoarding();
        return MaterialPageRoute(
          builder: (context) => const OutBoardingView(),
        );
      case Routes.mainHome:
        initMainHome();
        return MaterialPageRoute(
          builder: (context) => const MainHomeView(),
        );
      case Routes.home:
        initHome();
        return MaterialPageRoute(
          builder: (context) => const HomeView(),
        );
      case Routes.doctorDetails:
        initDoctorDetails();
        return MaterialPageRoute(
          builder: (context) => const DoctorDetailsView(),
        );
      case Routes.doctorAppointment:
        initDoctorAppointments();
        return MaterialPageRoute(
          builder: (context) => const DoctorAppointmentView(),
        );
      case Routes.popularDoctors:
        initPopularDoctors();
        return MaterialPageRoute(
          builder: (context) => const PopularDoctorsView(),
        );
      case Routes.profile:
        initProfile();
        return MaterialPageRoute(
          builder: (context) => const ProfileView(),
        );
      case Routes.medicalRecords:
        initMedicalRecords();
        return MaterialPageRoute(
          builder: (context) => const MedicalRecordsView(),
        );
      case Routes.addRecord:
        initMedicalRecords();
        return MaterialPageRoute(
          builder: (context) => const AddMedicalRecordView(),
        );
      case Routes.chats:
        initChats();
        return MaterialPageRoute(
          builder: (context) => const ChatsView(),
        );
      case Routes.messages:
        initMessages();
        return MaterialPageRoute(
          builder: (context) => const MessagesView(),
        );
      case Routes.mainContainer:
        initMainContainer();
        return MaterialPageRoute(
          builder: (context) => const MainContainerView(),
        );
      case Routes.medicalOrders:
        initMedicineOrders();
        return MaterialPageRoute(
          builder: (context) => const MedicineOrdersView(),
        );
      case Routes.settings:
        initSettings();
        return MaterialPageRoute(
          builder: (context) => const SettingsView(),
        );
      case Routes.bookings:
        initBookings();
        return MaterialPageRoute(
          builder: (context) => const BookingsView(),
        );
      case Routes.healthCheckups:
        initHealthCheckups();
        return MaterialPageRoute(
          builder: (context) => const HealthCheckupsView(),
        );
      case Routes.myDoctors:
        initMyDoctors();
        return MaterialPageRoute(
          builder: (context) => const MyDoctorsView(),
        );
      case Routes.privacyAndPolicy:
        initPrivacy();
        return MaterialPageRoute(
          builder: (context) => const PrivacyAndPolicyView(),
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(
            ManagerStrings.noRouteFound,
          ),
        ),
        body: Center(
          child: Text(
            ManagerStrings.noRouteFound,
          ),
        ),
      ),
    );
  }
}
