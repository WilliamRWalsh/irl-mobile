import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginState extends ChangeNotifier {
  LoginState();

  bool _isLogged = false;
  bool get isLogged => _isLogged;

  bool _isVerify = false;
  bool get isVerifying => _isVerify;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _pendingVerification = false;
  bool get pendingVerification => _pendingVerification;

  String _verificationId;
  String get verificationId => _verificationId;
  set verificationId(String verificationId) => _verificationId;

  Future verifyCode(String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    _pendingVerification = true;
    notifyListeners();

    try {
      final response = await _auth.signInWithCredential(credential);
    } catch (error) {
      _pendingVerification = false;
      notifyListeners();
      log('sscc: verifyCode - $error', level: 2);
      return;
    }
    _isLogged = true;
    _pendingVerification = false;
    notifyListeners();
  }

  Future verifyPhoneNumber(String number) async {
    var verifyPhoneNumber = _auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) {
        // is this auto?
        print('sscc: verificationCompleted');
      },
      verificationFailed: (FirebaseAuthException e) {
        log('sscc: verificationFailed - $e', level: 2);
      },
      codeSent: (String verificationId, int resendToken) {
        // save in outside state -- or maybe pass throw navigator
        _verificationId = verificationId;
        _isVerify = true;
        notifyListeners();

        print('sscc: codeSent: ' + verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('sscc: codeAutoRetrievalTimeout', level: 1);
        _verificationId = verificationId;
      },
      timeout: Duration(seconds: 60),
    );

    _pendingVerification = true;
    notifyListeners();

    await verifyPhoneNumber;

    _pendingVerification = false;
    notifyListeners();
  }
}
