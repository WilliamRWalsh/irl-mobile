// @dart=2.12

import 'dart:async';

// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slim_sams_cal_calc/models/goal_modal.dart';

const DEFAULT_GOAL = 2000;

class GoalState extends ChangeNotifier {
  GoalState({required this.userID}) {
    _goalStream = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('goals')
        .snapshots();

    _subscription = _goalStream.listen((snapshot) {
      List docs = snapshot.docs;
      if (docs.isEmpty) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(userID)
            .collection('goals')
            .doc()
            .set(
          {
            'calorieGoal': DEFAULT_GOAL,
          },
        );
        return;
      }
      Map<String, dynamic> data = docs.last.data();
      data['id'] = docs.last.id;
      _goal = GoalModel.fromJson(data);
      notifyListeners();
    });
  }

  String userID;

  late StreamSubscription<QuerySnapshot> _subscription;
  late Stream<QuerySnapshot> _goalStream;

  GoalModel? _goal;
  GoalModel? get goal => _goal;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
