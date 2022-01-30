// @dart=2.12
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slim_sams_cal_calc/firebase/calories_firebase.dart';
import 'package:slim_sams_cal_calc/models/calories_modal.dart';
import 'package:slim_sams_cal_calc/screens/login/login_state.dart';
import 'package:slim_sams_cal_calc/screens/widgets/confirm_dailog.dart';

class LedgerCard extends StatelessWidget {
  LedgerCard({required this.calories, this.canDelete});
  final CaloriesModel calories;
  final bool? canDelete;

  @override
  Widget build(BuildContext context) {
    final LoginState loginState = Provider.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white70,
        border: Border(),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.yellow.withOpacity(0.7),
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              calories.calories.toString(),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Positioned(
              right: 0,
              top: 0,
              child: IconButton(
                icon: Icon(Icons.cancel_outlined),
                onPressed: () async {
                  if (!(canDelete ?? true)) {
                    return;
                  }
                  bool isApproved = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmDialog(
                          widget: LedgerCard(
                        calories: calories,
                        canDelete: false,
                      ));
                    },
                  );

                  if (isApproved) {
                    CaloriesFirebase().deleteCalories(
                        loginState.user?.uid ?? '', calories.id);
                  }
                },
              )),
        ],
      ),
    );
  }
}
