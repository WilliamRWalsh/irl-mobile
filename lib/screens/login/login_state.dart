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

  bool _pendingPhoneVerification = false;
  bool get pendingPhoneVerification => _pendingPhoneVerification;

  bool _pendingCodeVerification = false;
  bool get pendingCodeVerification => _pendingCodeVerification;

  String _verificationId;
  String get verificationId => _verificationId;
  set verificationId(String verificationId) => _verificationId;

  Future verifyCode(String smsCode) async {
    print('LoginState: _pendingCodeVerification = true');
    _pendingCodeVerification = true;
    notifyListeners();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    try {
      await _auth.signInWithCredential(credential);
    } catch (error) {
      _pendingCodeVerification = false;
      notifyListeners();
      log('LoginState: verifyCode - $error', level: 2);
      return;
    }
    _isLogged = true;
    _pendingCodeVerification = false;
    notifyListeners();
    print('LoginState: _pendingCodeVerification = false');
  }

  Future verifyPhoneNumber(String number) async {
    print('LoginState: _pendingVerification = true');
    _pendingPhoneVerification = true;
    notifyListeners();

    await _auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) {
        // is this auto?
        print('LoginState: verificationCompleted');
      },
      verificationFailed: (FirebaseAuthException e) {
        log('LoginState: verificationFailed - $e', level: 2);
      },
      codeSent: (String verificationId, int resendToken) {
        // save in outside state -- or maybe pass throw navigator
        _verificationId = verificationId;
        _isVerify = true;
        _pendingPhoneVerification = false;
        notifyListeners();

        print('LoginState: codeSent: ' + verificationId);
        print('LoginState: _pendingVerification = false');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('LoginState: codeAutoRetrievalTimeout', level: 1);
        _verificationId = verificationId;
      },
      timeout: Duration(seconds: 60),
    );
  }
}
