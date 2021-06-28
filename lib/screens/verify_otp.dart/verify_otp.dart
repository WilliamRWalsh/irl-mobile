import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyOTP extends StatefulWidget {
  const VerifyOTP({Key key});

  @override
  _VerifyOTPState createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Enter OTP'));
  }
}
