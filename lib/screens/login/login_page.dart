import 'package:flutter/material.dart';
import 'package:irl_mobile/screens/login/local_widgets/login_form.dart';
import 'package:irl_mobile/screens/login/local_widgets/verify_form.dart';
import 'package:irl_mobile/screens/login/login_state.dart';
import 'package:provider/provider.dart';

class Login extends StatelessWidget {
  const Login({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginState>(
          create: (BuildContext context) => LoginState(),
        ),
      ],
      child: Center(
        child: Builder(
          builder: (BuildContext context) {
            final LoginState loginState = Provider.of(context);
            return Container(
              width: 500,
              height: 300,
              child: Center(
                child: loginState.isVerifying ? VerifyForm() : LoginForm(),
              ),
            );
          },
        ),
      ),
    );
  }
}
