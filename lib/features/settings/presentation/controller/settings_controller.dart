import 'package:get/get.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/storage/local/app_settings_prefs.dart';

import '../../../../core/local/locale_controller.dart';

class SettingsController extends GetxController {
  AppSettingsPrefs prefs = instance<AppSettingsPrefs>();
  String language = '';
  bool textMessagesValue = true;
  bool phoneCallsValue = false;

  onTextMessagesValueChanged() {
    textMessagesValue = !textMessagesValue;
    update();
  }

  onPhoneCallsValueChanged() {
    phoneCallsValue = !phoneCallsValue;
    update();
  }

  getLanguage() {
    language = prefs.getLocale();
    if (language == ManagerStrings.en) {
      language = ManagerStrings.english;
    } else if (language == ManagerStrings.ar) {
      language = ManagerStrings.arabic;
    }
    update();
    print(language);
  }
  changeLanguage(lang){
    final localController = Get.put<LocaleController>(LocaleController());
    localController.changeLanguage(lang);
  }

  @override
  void onInit() {
    getLanguage();
    super.onInit();
  }
}
