import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slim_sams_cal_calc/models/goal_modal.dart';

const DEFAULT_GOAL = 2000;

class GoalState extends ChangeNotifier {
  GoalState({this.userID}) {
    _goalStream ??= FirebaseFirestore.instance
        .collection('goals')
        .where("userID", isEqualTo: userID)
        .snapshots();

    _subscription = _goalStream.listen((snapshot) {
      List docs = snapshot.docs;
      if (docs.isEmpty) {
        FirebaseFirestore.instance.collection('goals').doc().set(
          {
            'userID': userID,
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

  StreamSubscription<QuerySnapshot> _subscription;
  Stream<QuerySnapshot> _goalStream;

  GoalModel _goal;
  GoalModel get goal => _goal;

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
