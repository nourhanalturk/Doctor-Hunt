import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

// INITIALIZE
  Future<void> initNotification() async {
    if (_isInitialized) return; // prevent re-initialization

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
// prepare android init settings
    const initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

// prepare ios init settings
    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

// init settings
    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await notificationsPlugin.initialize(initSettings);
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
      ), // AndroidNotificationDetails
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }

  // Future<void> scheduleReminderNotification({
  //   required int hour,
  //   required int reminderMinutesBefore,
  //   required String title,
  //   required String body,
  //   int id = 0,
  // }) async {
  //   final now = tz.TZDateTime.now(tz.local);
  //   var scheduledDate = tz.TZDateTime(
  //     tz.local,
  //     now.year,
  //     now.month,
  //     now.day,
  //     hour,
  //     reminderMinutesBefore,
  //   );
  //   notificationsPlugin.zonedSchedule(
  //     id,
  //     title,
  //     body,
  //     scheduledDate,
  //     notificationDetails(),
  //     androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
  //   );
  // }
  Future<void> scheduleNotification() async {
    final scheduledTime = tz.TZDateTime.now(tz.local).add(Duration(seconds: 15));

    await notificationsPlugin.zonedSchedule(
      1,
      'موعدك',
      'لديك إشعار مجدول',
      scheduledTime,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'channel_id',
          'الإشعارات المهمة',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle, // ← الإعداد الجديد
    );
  }
  Future<void> cancelNotifications()async{
   await notificationsPlugin.cancelAll();
  }


}
