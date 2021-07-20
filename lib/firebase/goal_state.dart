import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GoalState extends ChangeNotifier {
  StreamSubscription<QuerySnapshot> _subscription;

  GoalState() {
    _goalStream ??= FirebaseFirestore.instance
        .collection('goals')
        .where("user", isEqualTo: "")
        .snapshots();
    _subscription = _goalStream.listen((snapshot) {
      Map<String, dynamic> data = snapshot.docs.first.data();
      _goal = data['calories'];
    });
  }

  Stream<QuerySnapshot> _goalStream;
  Stream<QuerySnapshot> get goalStream => _goalStream;

  int _goal;
  int get goal => _goal;
}
