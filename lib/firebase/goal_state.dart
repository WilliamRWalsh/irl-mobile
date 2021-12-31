import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:irl_mobile/models/goal_modal.dart';

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
            'calorieGoal': 2000,
          },
        );
        return;
      }
      Map<String, dynamic> data = docs.last.data();
      data['id'] = docs.first.id;
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
