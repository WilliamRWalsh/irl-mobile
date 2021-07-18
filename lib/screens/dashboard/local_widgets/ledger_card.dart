import 'package:flutter/material.dart';
import 'package:irl_mobile/models/calories_modal.dart';

class LedgerCard extends StatelessWidget {
  final Calories calories;

  LedgerCard({this.calories});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border(),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.6),
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: SizedBox(
        height: 50,
        width: 300,
        child: Center(child: Text('+' + calories.calories.toString())),
      ),
    );
  }
}
