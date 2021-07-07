import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:irl_mobile/screens/login/login_state.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatelessWidget {
  LoginForm();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final LoginState loginState = Provider.of(context);
    final TextEditingController phoneController = TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 8, 50, 8),
            child: TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.phone),
                labelText: 'Phone Number',
              ),
              onSaved: (val) {
                phoneController.text = '+1$val';
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(175, 50),
              ),
              onPressed: () async {
                _formKey.currentState.save();
                if (!_formKey.currentState.validate()) {
                  return;
                }

                await loginState.verifyPhoneNumber(phoneController.text);
              },
              child: Text('Send Code'),
            ),
          ),
        ],
      ),
    );
  }
}

// set up verfiy code input on codeSent
