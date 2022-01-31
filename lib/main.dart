import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:slim_sams_cal_calc/notifications/daily_reminders.dart';
import 'package:slim_sams_cal_calc/screens/dashboard/dashboard.dart';
import 'package:slim_sams_cal_calc/screens/dashboard/progress.dart';
import 'package:slim_sams_cal_calc/screens/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:slim_sams_cal_calc/screens/login/login_state.dart';
import 'package:slim_sams_cal_calc/theme.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  startDailyReminders();

  AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_tests',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.High,
        ),
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupkey: 'basic_tests',
          channelGroupName: 'Basic tests',
        ),
      ],
      debug: true);

  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      // This is just a basic example. For real apps, you must show some
      // friendly dialog box before call the request method.
      // This is very important to not harm the user experience
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
  runApp(App());
}

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return Center(
        child: Text(
          _error.toString(),
        ),
      );
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return CircularProgressIndicator();
    }

    return SlimSamsApp();
  }
}

class SlimSamsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    precacheImage(AssetImage("assets/sam-face.jpg"), context);

    return ChangeNotifierProvider(
      create: (context) => LoginState(),
      child: MaterialApp(
        theme: myTheme(context),
        routes: {
          '/': (context) => Home(),
          '/dashboard': (context) => Dashboard(),
          '/dashboard/home': (context) => Home(),
          '/dashboard/progress': (context) => Progress(),
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LoginState loginState = Provider.of(context);

    if (loginState.isLogged) {
      WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.pushNamed(
            context,
            '/dashboard',
          ));
      return Scaffold(backgroundColor: Colors.blue[50], body: null);
    }
    return Scaffold(
      body: SafeArea(
        child: Login(),
      ),
    );
  }
}
