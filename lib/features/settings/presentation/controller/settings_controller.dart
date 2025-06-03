import 'package:get/get.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/storage/local/app_settings_prefs.dart';

class SettingsController extends GetxController {
  AppSettingsPrefs prefs = instance<AppSettingsPrefs>();
  String language = '';

  getLanguage() {
    language = prefs.getLocale();
    if (language == ManagerStrings.en) {
      language = ManagerStrings.english;
    } else if (language == ManagerStrings.ar) {
      language = ManagerStrings.arabic;
    }
    update();
  }

  @override
  void onInit() {
    getLanguage();
    super.onInit();
  }
}
