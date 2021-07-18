import 'package:flutter/material.dart';
import 'package:irl_mobile/screens/login/login_state.dart';
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
            padding:
                const EdgeInsets.only(left: 100, right: 100, top: 8, bottom: 8),
            child: TextFormField(
              controller: codeController,
              maxLength: 6,
              keyboardType: TextInputType.phone,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock),
                fillColor: Colors.black,
                counterText: "",
              ),
              autofocus: true,
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
