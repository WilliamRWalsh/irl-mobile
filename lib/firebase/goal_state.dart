import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:irl_mobile/models/goal_modal.dart';

class GoalState extends ChangeNotifier {
  GoalState() {
    _goalStream ??= FirebaseFirestore.instance
        .collection('goals')
        .where("userID", isEqualTo: "TwSqyUZyg5Zy8k6IwAtNpMY8e1E3")
        .snapshots();

    _subscription = _goalStream.listen((snapshot) {
      Map<String, dynamic> data = snapshot.docs.last.data();
      data['id'] = snapshot.docs.first.id;
      _goal = GoalModel.fromJson(data);
      notifyListeners();
    });
  }

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
