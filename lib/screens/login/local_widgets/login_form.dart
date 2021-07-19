import 'package:flutter/material.dart';
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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 100, right: 100, top: 8, bottom: 8),
            child: TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone),
                fillColor: Colors.black,
              ),
              autofocus: true,
              onSaved: (val) {
                phoneController.text = '+1$val';
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(175, 50),
                primary: Theme.of(context).buttonColor,
                onPrimary: Theme.of(context).primaryColorDark,
                textStyle: Theme.of(context).textTheme.button,
              ),
              onPressed: () async {
                _formKey.currentState.save();
                if (!_formKey.currentState.validate()) {
                  return;
                }

                await loginState.verifyPhoneNumber(phoneController.text);
              },
              child: Text('Verify Phone Number'),
            ),
          ),
        ],
      ),
    );
  }
}

// set up verfiy code input on codeSent
