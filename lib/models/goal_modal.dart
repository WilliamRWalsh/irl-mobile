import 'package:json_annotation/json_annotation.dart';

part 'goal_modal.g.dart';

@JsonSerializable()
class GoalModel {
  GoalModel(this.id, this.calorieGoal, this.userID);

  String id;
  int calorieGoal;
  String userID;

  factory GoalModel.fromJson(Map<String, dynamic> json) =>
      _$GoalModelFromJson(json);

  Map<String, dynamic> toJson() => _$GoalModelToJson(this);
}
