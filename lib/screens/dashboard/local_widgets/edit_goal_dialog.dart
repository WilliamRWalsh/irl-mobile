import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slim_sams_cal_calc/firebase/goal_state.dart';
import 'package:slim_sams_cal_calc/screens/login/login_state.dart';
import 'package:provider/provider.dart';
import 'package:slim_sams_cal_calc/screens/widgets/my_dialog.dart';

class EditGoalDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => GoalState(),
        ),
      ],
      child: Builder(
        builder: (BuildContext context) {
          final LoginState loginState = Provider.of(context, listen: false);
          final GoalState goalState = Provider.of(context, listen: false);

          return MyDialog(
            title: 'What is your daily calorie goal?',
            onConfirm: (String value) async {
              FirebaseFirestore.instance
                  .collection('goals')
                  .doc(goalState.goal?.id ?? null)
                  .update(
                {
                  'userID': loginState.user.uid,
                  'calorieGoal': int.parse(value),
                },
              );
            },
          );
        },
      ),
    );
  }
}
