import 'package:flutter/material.dart';
import 'package:irl_mobile/screens/login/local_widgets/login_form.dart';
import 'package:irl_mobile/screens/login/local_widgets/verify_form.dart';
import 'package:irl_mobile/screens/login/login_state.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login();

  @override
  Widget build(BuildContext context) {
    final LoginState loginState = Provider.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!loginState.isVerifying) ...[
          CircleAvatar(
            radius: 91,
            backgroundColor: Colors.black,
            child: CircleAvatar(
              foregroundImage: AssetImage('assets/sam-face.jpg'),
              radius: 85,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 15),
            child: Text(
              'Slim Sam\'s Cal Calc',
              style: Theme.of(context).textTheme.headline2,
            ),
          )
        ],
        Container(
          child: loginState.pendingVerification
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: loginState.isVerifying ? VerifyForm() : LoginForm(),
                ),
        ),
      ],
    );
  }
}
