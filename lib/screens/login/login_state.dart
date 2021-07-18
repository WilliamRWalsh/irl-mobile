import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginState extends ChangeNotifier {
  LoginState() {
    FirebaseAuth.instance.userChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        _isLogged = true;
        _user = user;
        print('User is signed in!');
      }
    });
  }

  User _user;
  User get user => _user;

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
    print('LoginState: _pendingVerification = true');
    _pendingVerification = true;
    notifyListeners();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    try {
      await _auth.signInWithCredential(credential);
    } catch (error) {
      _pendingVerification = false;
      notifyListeners();
      log('LoginState: verifyCode - $error', level: 2);
      return;
    }
    _isLogged = true;
    notifyListeners();
    print('LoginState: _pendingVerification = false');
  }

  Future verifyPhoneNumber(String number) async {
    print('LoginState: _pendingVerification = true');
    _pendingVerification = true;
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
        _pendingVerification = false;
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
