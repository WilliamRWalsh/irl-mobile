import 'package:flutter/material.dart';
import 'package:irl_mobile/screens/dashboard/dashboard.dart';
import 'package:irl_mobile/screens/login/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:irl_mobile/screens/login/login_state.dart';
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
    return MaterialApp(
      theme: ThemeData(
        // Colors
        brightness: Brightness.light,
        primaryColor: Colors.blue[300],
        errorColor: Colors.red,
        accentColor: Colors.green[200],
        buttonColor: Colors.yellow[600],
        primaryColorDark: Colors.black,

        // Widget Themes
        inputDecorationTheme:
            InputDecorationTheme(fillColor: Theme.of(context).primaryColorDark),

        // Text
        textTheme: TextTheme(
          button: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
          bodyText2: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          headline1: TextStyle(
            fontSize: 92,
            color: Colors.blue[600],
            fontWeight: FontWeight.w300,
          ),
          headline2: TextStyle(
            fontSize: 38,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[500],
          ),
          headline3: TextStyle(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey[700],
          ),
        ),
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue[50],
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) => LoginState(),
            ),
          ],
          child: SafeArea(
            child: Builder(
              builder: (context) {
                final LoginState loginState = Provider.of(context);
                return loginState.isLogged ? Dashboard() : Login();
              },
            ),
          ),
        ),
      ),
    );
  }
}
