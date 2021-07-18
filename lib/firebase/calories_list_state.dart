import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CaloriesListState extends ChangeNotifier {
  CaloriesListState({this.userID}) {
    _caloriesStream ??= FirebaseFirestore.instance
        .collection('calories')
        .orderBy('createdAt', descending: false)
        .snapshots();
  }

  String userID;

  Stream<QuerySnapshot> _caloriesStream;
  Stream<QuerySnapshot> get caloriesStream => _caloriesStream;
}
