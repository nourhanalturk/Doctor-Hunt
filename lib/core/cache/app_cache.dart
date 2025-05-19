import 'package:tender/core/extensions/extensions.dart';

/// A class defined for cache data thats used and when close app deleted
class CacheData {
  static String email = "";
  static String courseUid = "";
  static String instructorName = "";
  static String userName = "";
  static int doctorDetailsId = 0;

  static String doctorName = "";
  static String doctorSpeciality = "";
  static double doctorRating = 0.0;
  static String doctorImage = "";
  static double doctorCoastPerHour = 0.0;

  static String chatUid = "";

  static void setChatUid(String uid) {
    chatUid = uid;
  }

  static String getChatUid() => chatUid;

  static void setDoctorName(String value) => doctorName = value;

  static String getDoctorName() => doctorName;

  static void setDoctorSpeciality(String value) => doctorSpeciality = value;

  static String getDoctorSpeciality() => doctorSpeciality;

  static void setDoctorRating(double value) => doctorRating = value;

  static double getDoctorRating() => doctorRating;

  static void setDoctorImage(String value) => doctorImage = value;

  static String getDoctorImage() => doctorImage;

  static void setDoctorCoastPerHour(double value) => doctorCoastPerHour = value;

  static double getDoctorCoastPerHour() => doctorCoastPerHour;

  /// Set the email to cache as a static
  static void setEmail({
    required String value,
  }) {
    email = value;
  }

  /// Get the email from the cache
  static String getEmail() {
    return email;
  }

  static void setDoctorDetailsId({
    required int value,
  }) {
    doctorDetailsId = value;
  }

  static int getDoctorDetailsId() {
    return doctorDetailsId;
  }

  static void setUserName({
    required String name,
  }) {
    userName = name;
  }

  /// Get the email from the cache
  static String getUserName() {
    return userName;
  }

  void setCourseUid({
    required String value,
  }) {
    courseUid = value;
  }

  String getCourseUid() {
    return courseUid;
  }
}
