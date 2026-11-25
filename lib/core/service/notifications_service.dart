import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotiService {
  NotiService();

  static final NotiService shared = NotiService();

  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initNotification() async {
    if (_isInitialized) return;

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

    await notificationsPlugin.initialize(initSettings);
    _isInitialized = true;
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily Notifications',
        channelDescription: 'Daily Notification Channel',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    await notificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }

  /// Schedules one reminder at [minutesBefore] the appointment time.
  /// Past times are ignored instead of firing immediately.
  Future<void> scheduleAppointmentReminder({
    required DateTime appointmentTime,
    required int minutesBefore,
    required String title,
    required String body,
  }) async {
    await initNotification();

    final DateTime scheduledTime =
        appointmentTime.subtract(Duration(minutes: minutesBefore));
    if (!scheduledTime.isAfter(DateTime.now())) return;

    await notificationsPlugin.zonedSchedule(
      appointmentTime.millisecondsSinceEpoch % 1000000000,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  /// Kept for compatibility with older callers.
  Future<void> scheduleNotification() async {
    await scheduleAppointmentReminder(
      appointmentTime: DateTime.now().add(const Duration(seconds: 15)),
      minutesBefore: 0,
      title: 'Appointment',
      body: 'You have an upcoming appointment',
    );
  }

  Future<void> cancelNotifications() async {
    await notificationsPlugin.cancelAll();
  }
}
