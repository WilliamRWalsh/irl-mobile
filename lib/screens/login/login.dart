import 'package:flutter/material.dart';
import 'package:irl_mobile/screens/login/local_widgets/login_form.dart';

class Login extends StatelessWidget {
  const Login({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 500,
        height: 300,
        child: Center(child: LoginForm()),
      ),
    );
  }
}
