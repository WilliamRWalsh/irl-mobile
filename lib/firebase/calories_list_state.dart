import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:irl_mobile/models/calories_modal.dart';

class CaloriesListState extends ChangeNotifier {
  CaloriesListState({this.userID}) {
    _caloriesStream ??= FirebaseFirestore.instance
        .collection('calories')
        .where("userID", isEqualTo: "TwSqyUZyg5Zy8k6IwAtNpMY8e1E3")
        .orderBy('createdAt', descending: false)
        .snapshots();

    _subscription = _caloriesStream.listen((snapshot) {
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

  String userID;

  int _calorieTotal;
  int get calorieTotal => _calorieTotal;

  List<CaloriesModel> _caloriesList;
  List<CaloriesModel> get caloriesList => _caloriesList;

  Stream<QuerySnapshot> _caloriesStream;
  Stream<QuerySnapshot> get caloriesStream => _caloriesStream;

  StreamSubscription<QuerySnapshot> _subscription;
}
