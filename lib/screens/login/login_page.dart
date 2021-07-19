import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
        CircleAvatar(
          radius: 91,
          backgroundColor: Colors.blue[400],
          child: CircleAvatar(
            foregroundImage: AssetImage('assets/sam-face.jpg'),
            radius: 85,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0, bottom: 15),
          child: Text(
            'Slim Sam\'s Cal Calc',
            style: GoogleFonts.lobster(
              fontSize: 42,
              color: Colors.blue[400],
            ),
          ),
        ),
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
