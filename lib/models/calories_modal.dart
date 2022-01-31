// @dart=2.12

import 'package:json_annotation/json_annotation.dart';

part 'calories_modal.g.dart';

@JsonSerializable()
class CaloriesModel {
  CaloriesModel(this.id, this.calories, this.createdAt, this.userID);

  String id;
  int calories;
  DateTime createdAt;
  String userID;

  factory CaloriesModel.fromJson(Map<String, dynamic> json, String id) {
    json['id'] = id;
    json['createdAt'] = DateTime.fromMillisecondsSinceEpoch(
      json['createdAt'].millisecondsSinceEpoch,
    );
    return _$CaloriesModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CaloriesModelToJson(this);
}
