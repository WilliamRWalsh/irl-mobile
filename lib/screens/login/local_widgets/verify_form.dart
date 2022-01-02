// @dart=2.12
import 'package:flutter/material.dart';
import 'package:slim_sams_cal_calc/screens/login/login_state.dart';
import 'package:provider/provider.dart';

class VerifyForm extends StatelessWidget {
  VerifyForm();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final LoginState loginState = Provider.of(context);
    final TextEditingController codeController = TextEditingController();

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: TextFormField(
              controller: codeController,
              maxLength: 6,
              keyboardType: TextInputType.phone,
              style: Theme.of(context).textTheme.bodyText2,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: '6 digit code',
                fillColor: Colors.black,
                counterText: "",
                errorStyle: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              autofocus: true,
              validator: (String? val) {
                if (val?.isEmpty ?? true) {
                  return 'Please provide the code texted to you';
                }

                if (val!.length != 6) {
                  return 'Must be 6 digits';
                }
                return null;
              },
            ),
          ),
          if (loginState.invalidCode)
            Text(
              'Invalid code',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontFamily: 'AvenirNext',
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

                await loginState.verifyCode(codeController.text);
              },
              child: Text('Verify Code'),
            ),
          ),
        ],
      ),
    );
  }
}

// set up verfiy code input on codeSent
