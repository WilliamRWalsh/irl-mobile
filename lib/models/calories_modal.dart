import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calories_modal.g.dart';

@JsonSerializable()
class CaloriesModel {
  CaloriesModel(this.id, this.calories, this.createdAt, this.userID);

  String id;
  int calories;
  String
      createdAt; //TODO: Fix createdAt DateTime.fromMicrosecondsSinceEpoch(timestamp)
  String userID;

  factory CaloriesModel.fromJson(Map<String, dynamic> json) =>
      _$CaloriesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CaloriesModelToJson(this);
}
