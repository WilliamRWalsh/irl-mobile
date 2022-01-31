import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData myTheme(BuildContext context) {
  return ThemeData(
    // Colors
    brightness: Brightness.light,
    primaryColor: Colors.blue[300],
    errorColor: Colors.red,
    // ignore: deprecated_member_use
    accentColor: Colors.grey,
    // ignore: deprecated_member_use
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
      bodyText1: GoogleFonts.pangolin(
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
