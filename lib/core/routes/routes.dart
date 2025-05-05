import 'package:flutter/material.dart';
import 'package:tender/features/doctor_details/domain/di/di.dart';
import 'package:tender/features/doctor_details/presentation/view/doctor_details_view.dart';
import 'package:tender/features/login/domain/di/di.dart';
import 'package:tender/features/login/presentation/view/login_view.dart';
import 'package:tender/features/main_home/domain/di/di.dart';
import 'package:tender/features/main_home/presentation/view/main_home_view.dart';
import 'package:tender/features/out_boarding/presentation/view/out_boarding_view.dart';
import 'package:tender/features/popular_doctor/presentation/view/popular_doctors_view.dart';
import 'package:tender/features/register/domain/di/di.dart';
import 'package:tender/features/register/presentation/view/register_view.dart';
import 'package:tender/features/splash/domain/di.dart';
import 'package:tender/features/splash/presentation/view/splash_view.dart';
import '../../features/doctor_appointment/domain/di/di.dart';
import '../../features/doctor_appointment/presentation/view/appointment_view.dart';
import '../../features/home/domain/di/di.dart';
import '../../features/home/presentation/view/home_view.dart';
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
        initAppointment();
        return MaterialPageRoute(
          builder: (context) => const DoctorAppointmentView(),
        );
      case Routes.popularDoctors:
        initPopularDoctors();
        return MaterialPageRoute(
          builder: (context) => const PopularDoctorsView(),
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
