import 'package:flutter/material.dart';
import 'package:irl_mobile/screens/login/login_state.dart';
import 'package:provider/provider.dart';

class VerifyForm extends StatelessWidget {
  VerifyForm();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final LoginState loginState = Provider.of(context);
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
                labelText: '6 Digit Code',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: Size(175, 50)),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  await loginState.verifyCode();
                }
              },
              child: Text('Send Code'),
            ),
          ),
        ],
      ),
    );
  }
}
