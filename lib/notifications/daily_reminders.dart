// @dart=2.12
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> startDailyReminders() async {
  // Configure BackgroundFetch.
  try {
    var status = await BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval: 15,
          /*
        forceAlarmManager: false,
        stopOnTerminate: false,
        startOnBoot: true,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.NONE,

         */
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
  print('Background Task: $taskId');

  // check sharedPrefs if I should run
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'basic_channel',
      title: "Don't forget to track your calories!",
    ),
  );
  // mark run
  BackgroundFetch.finish(taskId);
}

void _onBackgroundFetchTimeout(String taskId) {
  //
  BackgroundFetch.finish(taskId);
}
