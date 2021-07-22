import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:irl_mobile/screens/login/login_state.dart';
import 'package:provider/provider.dart';

class AddCaloriesDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController caloriesController = TextEditingController();
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginState(),
      child: Builder(
        builder: (BuildContext context) {
          final LoginState loginState = Provider.of(context, listen: false);

          return AlertDialog(
            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                    ),
                    child: TextFormField(
                      controller: caloriesController,
                      keyboardType: TextInputType.phone,
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: const InputDecoration(
                        fillColor: Colors.black,
                      ),
                      autofocus: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(150, 50),
                        primary: Theme.of(context).buttonColor,
                        onPrimary: Theme.of(context).primaryColorDark,
                        textStyle: Theme.of(context).textTheme.button,
                      ),
                      onPressed: () async {
                        _formKey.currentState.save();
                        if (!_formKey.currentState.validate()) {
                          return;
                        }
                        FirebaseFirestore.instance
                            .collection('calories')
                            .doc()
                            .set(
                          {
                            'userID': loginState.user.uid,
                            'calories': int.parse(caloriesController.text),
                            'createdAt': DateTime.now(),
                          },
                        );
                        Navigator.pop(context);
                      },
                      child: Text('OK'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
