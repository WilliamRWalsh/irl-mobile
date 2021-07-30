import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irl_mobile/firebase/calories_list_state.dart';
import 'package:irl_mobile/firebase/goal_state.dart';
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
    var materialApp = MaterialApp(
      theme: myTheme(context),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue[50],
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (BuildContext context) => LoginState(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => CaloriesListState(),
            ),
            ChangeNotifierProvider(
              create: (BuildContext context) => GoalState(),
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
    return materialApp;
  }

  ThemeData myTheme(BuildContext context) {
    return ThemeData(
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
        button: GoogleFonts.notoSans(
          fontWeight: FontWeight.w800,
          color: Colors.blueGrey[700],
          fontSize: 24,
        ),
        // User variable
        bodyText1: GoogleFonts.caveat(
          color: Colors.black,
          fontSize: 42,
        ),
        // Labels
        bodyText2: GoogleFonts.domine(
          fontSize: 34,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        // Display #1
        headline1: GoogleFonts.domine(
          fontSize: 40,
          color: Colors.grey[800],
          fontWeight: FontWeight.w300,
        ),
        // Display #2
        headline2: GoogleFonts.caveat(
          color: Colors.blueGrey[700],
          fontWeight: FontWeight.bold,
          fontSize: 44,
        ),
        headline3: GoogleFonts.caveat(
          color: Colors.blueGrey[700],
          fontWeight: FontWeight.bold,
          fontSize: 50,
        ),
        headline4: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.bold,
          color: Colors.blue[300],
        ),
      ),
    );
  }
}
