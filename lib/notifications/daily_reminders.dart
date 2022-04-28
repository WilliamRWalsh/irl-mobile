// @dart=2.12
import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> startDailyReminders() async {
  // Configure BackgroundFetch.
  try {
    var status = await BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval: 15,
        ),
        _onBackgroundFetch,
        _onBackgroundFetchTimeout);

    print('[BackgroundFetch] configure success: $status');
  } on Exception catch (e) {
    print("[BackgroundFetch] configure ERROR: $e");
  }
}

void _onBackgroundFetch(String taskId) async {
  await Firebase.initializeApp();
  log('BackgroundFetch: Started', level: 0);

  final currentDayOfMonth = DateTime.now().day;
  final currentHour = DateTime.now().hour;

  if (currentHour < 12) {
    log('BackgroundFetch: Before noon', level: 0);
    return;
  }

  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? lastReminderDOM = prefs.getInt('lastReminderDOM');

  bool sendNotifications = prefs.getBool('sendNotifications') ?? true;
  if (!sendNotifications) {
    log('BackgroundFetch: sendNotifications is false', level: 0);
    return;
  }

  if (currentDayOfMonth == lastReminderDOM) {
    log('BackgroundFetch: Already run today', level: 0);
    return;
  }

  await prefs.setInt('lastReminderDOM', currentDayOfMonth);

  log('BackgroundFetch: Send notification', level: 0);
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1,
        channelKey: 'basic_channel',
        title: "Slim Sam says...",
        body: "'Don't forget to add your calories!'"),
  );
  BackgroundFetch.finish(taskId);
}

void _onBackgroundFetchTimeout(String taskId) {
  log('BackgroundFetch: Timeout', level: 2);
  BackgroundFetch.finish(taskId);
}
