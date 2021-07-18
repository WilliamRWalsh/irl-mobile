import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:irl_mobile/screens/dashboard/local_widgets/ledger.dart';
import 'package:irl_mobile/screens/login/login_state.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final LoginState loginState = Provider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: Text(
                  'Cal\'s Remaining'.toUpperCase(),
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
              Flexible(
                flex: 4,
                child: Text(
                  "1425",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Flexible(
                flex: 1,
                child: Text(
                  'Ledger',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              Flexible(
                flex: 8,
                child: Ledger(),
              ),
              Flexible(
                flex: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(195, 80),
                    primary: Theme.of(context).buttonColor,
                    onPrimary: Theme.of(context).primaryColorDark,
                    textStyle: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 15),
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
                                    controller: TextEditingController(),
                                    keyboardType: TextInputType.phone,
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
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
                                      onPrimary:
                                          Theme.of(context).primaryColorDark,
                                      textStyle:
                                          Theme.of(context).textTheme.button,
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
                                          'user': loginState.user.uid,
                                          'calories': 101,
                                          'createdAt': DateTime.now(),
                                        },
                                      );
                                    },
                                    child: Text('OK'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                  child: Text('Add Calories'),
                ),
              ),
              SizedBox(
                height: 14,
              )
            ],
          ),
        ),
      ),
    );
  }
}
