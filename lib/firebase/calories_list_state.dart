import 'package:flutter/material.dart';
import 'package:irl_mobile/models/calories_modal.dart';

class CaloriesListState extends ChangeNotifier {
  CaloriesListState({this.userID});

  String userID;

  List<Calories> _caloriesList = [];
  bool _pendingGetCaloriesList;

  bool get pendingGetCaloriesList => _pendingGetCaloriesList;

  List<Calories> getCaloriesList() {
    return [];
  }
}
