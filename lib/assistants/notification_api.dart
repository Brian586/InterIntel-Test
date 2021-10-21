
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
          "channel id",
          "channel name",
          channelDescription: "channel description",
        importance: Importance.max
      ),
      iOS: IOSNotificationDetails()
    );
  }

  static Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings("@mipmap/ic_launcher");
    const iOS = IOSInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: android,
      iOS: iOS,
    );

    await _notifications.initialize(
        initializationSettings,
        onSelectNotification: (payload) async {
          onNotifications.add(payload);
        }
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload}) async => _notifications.show(id, title, body, await _notificationDetails());
}