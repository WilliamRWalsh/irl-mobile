import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irl_mobile/firebase/calories_list_state.dart';
import 'package:irl_mobile/firebase/goal_state.dart';
import 'package:irl_mobile/screens/dashboard/dashboard.dart';
import 'package:irl_mobile/screens/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:irl_mobile/screens/login/login_state.dart';
import 'package:irl_mobile/theme.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
    return ChangeNotifierProvider(
      create: (context) => LoginState(),
      child: MaterialApp(
        theme: myTheme(context),
        routes: {
          '/': (context) => Home(),
          '/dashboard': (context) => Dashboard(),
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
    }
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Login(),
      ),
    );
  }
}
