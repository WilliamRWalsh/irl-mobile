// @dart=2.12
import 'package:flutter/material.dart';
import 'package:slim_sams_cal_calc/screens/login/login_state.dart';
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
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.phone),
                fillColor: Colors.black,
                errorStyle: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              autofocus: true,
              validator: (String? val) {
                if (val?.isEmpty ?? true) {
                  return 'Please provide phone number';
                }

                if (val!.length != 10) {
                  return 'Invalid phone number';
                }
                return null;
              },
              onSaved: (val) {
                // Form.of(context)!.validate();
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
                _formKey.currentState?.save();
                if (!(_formKey.currentState?.validate() ?? false)) {
                  return;
                }
                await loginState.verifyPhoneNumber('+1${phoneController.text}');
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
