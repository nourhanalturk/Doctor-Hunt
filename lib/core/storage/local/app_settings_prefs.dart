import 'package:shared_preferences/shared_preferences.dart';
import '../../../config/constants/constants.dart';
import '../../../config/constants/shared_prefs_constants.dart';
import 'package:tender/core/extensions/extensions.dart';

class AppSettingsPrefs {
  final SharedPreferences _sharedPreferences;

  clear() {
    _sharedPreferences.clear();
  }

  AppSettingsPrefs(
    this._sharedPreferences,
  );

  Future<void> setToken({
    required String token,
  }) async {
    await _sharedPreferences.setString(
      Constants.token,
      token,
    );
  }

  /// Get the user token
  String getToken() {
    return _sharedPreferences.getString(Constants.token).onNull();
  }

  Future<void> setUserImage({
    required String imagePath,
  }) async {
    await _sharedPreferences.setString(
      SharedPrefsConstants.patientImage,
      imagePath,
    );
  }

  String getUserImage() {
    return _sharedPreferences.getString(SharedPrefsConstants.patientImage,).onNullImage();
  }

  /// Set if the user logged in is true
  Future<void> setIsUserLoggedIn(bool isLoggedIn) async {
    await _sharedPreferences.setBool(
      Constants.isLoggedIn,
      isLoggedIn,
    );
  }

  /// Get if the user logged
  bool getUserLoggedIn() {
    return _sharedPreferences
        .getBool(
          Constants.isLoggedIn,
        )
        .onNull();
  }

  Future<void> setLocale(String locale) async {
    await _sharedPreferences.setString(SharedPrefsConstants.locale, locale);
  }

  String getLocale() {
    return _sharedPreferences
        .getString(SharedPrefsConstants.locale)
        .pareWithDefaultLocale();
  }

  Future<void> setOutBoardingViewed() async {
    await _sharedPreferences.setBool(
        SharedPrefsConstants.outBoardingViewed, true);
  }

  bool getOutBoardingViewed() {
    return _sharedPreferences
        .getBool(
          SharedPrefsConstants.outBoardingViewed,
        )
        .onNull();
  }
  Future<void> setPatientUid(String uid) async {
    await _sharedPreferences.setString(SharedPrefsConstants.patientUid, uid);
  }

  String getPatientUid() {
    return _sharedPreferences.getString(SharedPrefsConstants.patientUid).onNull();
  }
  Future<void> setPatientName(String patientName) async {
    await _sharedPreferences.setString(SharedPrefsConstants.patientName, patientName);
  }

  String getPatientName() {
    return _sharedPreferences.getString(SharedPrefsConstants.patientName).onNull();
  }
}
