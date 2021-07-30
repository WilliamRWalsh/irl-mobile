import 'package:flutter/material.dart';
import 'package:irl_mobile/models/calories_modal.dart';

class LedgerCard extends StatelessWidget {
  LedgerCard({this.calories});
  final CaloriesModel calories;

  @override
  Widget build(BuildContext context) {
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
          Positioned(right: 10, top: 10, child: Icon(Icons.cancel_outlined)),
        ],
      ),
    );
  }
}
