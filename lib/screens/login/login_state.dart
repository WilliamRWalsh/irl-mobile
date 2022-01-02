import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginState extends ChangeNotifier {
  LoginState() {
    if (_auth.currentUser != null) {
      _isLogged = true;
      notifyListeners();
    }
    _auth.userChanges().listen((User user) {
      if (user == null) {
        log('LoginState: User is currently signed out!', level: 1);
      } else {
        log('LoginState: User is signed in!', level: 1);
        _isLogged = true;
        _user = user;
        notifyListeners();
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

  bool _invalidCode = false;
  bool get invalidCode => _invalidCode;

  String _verificationId;
  String get verificationId => _verificationId;
  set verificationId(String verificationId) => _verificationId;

  Future<void> verifyCode(String smsCode) async {
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
      _invalidCode = true;
      notifyListeners();
      log('LoginState: $error', level: 2);
      return;
    }
    _isLogged = true;
    _pendingVerification = false;
    _invalidCode = false;

    notifyListeners();
  }

  Future verifyPhoneNumber(String number) async {
    _pendingVerification = true;
    notifyListeners();

    await _auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) {
        log('LoginState: verificationCompleted', level: 1);
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
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('LoginState: codeAutoRetrievalTimeout', level: 1);
        _verificationId = verificationId;
      },
      timeout: Duration(seconds: 60),
    );
  }
}
