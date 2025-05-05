/// A class defined for cache data thats used and when close app deleted
class CacheData {
  static String email = "";
  static String courseUid = "";
  static String instructorName = "";
  static String userName = "";
  static int doctorDetailsId = 0;

  static void setInstructorName({required String instName}) {
    instructorName = instName;
  }

  static String getInstructorName() {
    return instructorName;
  }

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
