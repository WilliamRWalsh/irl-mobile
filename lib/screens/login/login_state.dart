import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginState extends ChangeNotifier {
  LoginState();

  bool _isVerify = false;
  bool get isVerifying => _isVerify;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _verificationId;
  String get verificationId => _verificationId;
  set verificationId(String verificationId) => _verificationId;

  Future verifyCode() async {
    String smsCode = '111111';

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final isSignedIn = await _auth.signInWithCredential(credential);
    print('sscc: $isSignedIn');
  }

  Future verifyPhoneNumber() async {
    var verifyPhoneNumber = _auth.verifyPhoneNumber(
      phoneNumber: '+13017752761',
      verificationCompleted: (PhoneAuthCredential credential) {
        // is this auto?
        print('sscc: verificationCompleted');
      },
      verificationFailed: (FirebaseAuthException e) {
        print('sscc: verificationFailed');
      },
      codeSent: (String verificationId, int resendToken) {
        // save in outside state -- or maybe pass throw navigator
        _verificationId = verificationId;
        _isVerify = true;
        notifyListeners();

        print('sscc: codeSent: ' + verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('sscc: codeAutoRetrievalTimeout');
        _verificationId = verificationId;
      },
      timeout: Duration(seconds: 60),
    );

    await verifyPhoneNumber;
  }
}
