import 'package:flutter/material.dart';
import 'package:irl_mobile/screens/dashboard/dashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Dashboard(),
      ),
    );
  }
}
