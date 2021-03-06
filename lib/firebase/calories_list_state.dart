import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:slim_sams_cal_calc/models/calories_modal.dart';
import 'package:slim_sams_cal_calc/screens/login/login_state.dart';

class CaloriesListState extends ChangeNotifier {
  CaloriesListState({this.userID}) {
    final now = DateTime.now();
    final lastMidnight = DateTime(now.year, now.month, now.day);
    final tonightMidnight = DateTime(now.year, now.month, now.day + 1);
    _caloriesStream ??= FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('calories')
        .where("createdAt",
            isGreaterThanOrEqualTo: lastMidnight, isLessThan: tonightMidnight)
        .orderBy('createdAt', descending: false)
        .snapshots();

    _caloriesStream.listen((snapshot) {
      _caloriesList = snapshot.docs.map(
        (doc) {
          Map<String, dynamic> data = doc.data();
          return CaloriesModel.fromJson(data, doc.id);
        },
      ).toList();
      _calorieTotal = _caloriesList.fold(
        0,
        (previousValue, element) => previousValue + element.calories,
      );

      notifyListeners();
    });
  }

  void updateDeps(LoginState loginState) {}

  String userID;

  int _calorieTotal;
  int get calorieTotal => _calorieTotal;

  List<CaloriesModel> _caloriesList;
  List<CaloriesModel> get caloriesList => _caloriesList;

  Stream<QuerySnapshot> _caloriesStream;
  Stream<QuerySnapshot> get caloriesStream => _caloriesStream;
}
