import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginForm extends StatefulWidget {
  const LoginForm({key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
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
                  style: ElevatedButton.styleFrom(minimumSize: Size(175, 50)),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      await signIn();
                    }
                  },
                  child: Text('Send Code')),
            )
          ],
        ));
  }

  Future signIn() async {
    var verifyPhoneNumber = _auth.verifyPhoneNumber(
      phoneNumber: '+1 123 456 7890',
      verificationCompleted: (PhoneAuthCredential credential) {
        // is this auto?
        print('verificationCompleted');
      },
      verificationFailed: (FirebaseAuthException e) {
        print('verificationFailed');
      },
      codeSent: (String verificationId, int resendToken) {
        // This is called first
        print('codeSent');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('codeAutoRetrievalTimeout');
      },
    );
    await verifyPhoneNumber;
  }
}
