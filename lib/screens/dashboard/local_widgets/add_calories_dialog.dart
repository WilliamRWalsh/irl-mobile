// @dart=2.12

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slim_sams_cal_calc/screens/login/login_state.dart';
import 'package:provider/provider.dart';
import 'package:slim_sams_cal_calc/screens/widgets/my_dialog.dart';

class AddCaloriesDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        final LoginState loginState = Provider.of(context, listen: false);

        return MyDialog(
          title: 'How many calories?',
          onConfirm: (String value) async {
            FirebaseFirestore.instance.collection('calories').doc().set(
              {
                'userID': loginState.user?.uid ?? '',
                'calories': int.parse(value),
                'createdAt': DateTime.now(),
              },
            );
          },
        );
      },
    );
  }
}
