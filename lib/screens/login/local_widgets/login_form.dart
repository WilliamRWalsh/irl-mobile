import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:irl_mobile/screens/verify_otp.dart/verify_otp.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginForm extends StatefulWidget {
  const LoginForm({key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  String _verificationId;
  bool _isLoading;

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      icon: Icon(Icons.phone),
                      labelText: 'Phone Number',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(minimumSize: Size(175, 50)),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          await verifyPhoneNumber();
                          setState(() {
                            _isLoading = true;
                          });
                        }
                      },
                      child: Text('Send Code')),
                ),
              ],
            ),
          );
  }

  Future verifyPhoneNumber() async {
    var verifyPhoneNumber = _auth.verifyPhoneNumber(
        phoneNumber: '+1 123 456 7890',
        verificationCompleted: (PhoneAuthCredential credential) {
          // is this auto?
          print('sscc: verificationCompleted');
        },
        verificationFailed: (FirebaseAuthException e) {
          print('sscc: verificationFailed');
        },
        codeSent: (String verificationId, int resendToken) {
          // save in outside state -- or maybe pass throw navigator
          setState(() {
            _verificationId = verificationId;
          });
          print('sscc: codeSent: ' + verificationId);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => VerifyOTP()));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print('sscc: codeAutoRetrievalTimeout');
          setState(() {
            _verificationId = verificationId;
          });
        },
        timeout: Duration(seconds: 60));

    await verifyPhoneNumber;
  }
}

// set up verfiy code input on codeSent
