// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_modal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoalModel _$GoalModelFromJson(Map<String, dynamic> json) {
  return GoalModel(
    json['id'] as String,
    json['calorieGoal'] as int,
    json['userID'] as String,
  );
}

Map<String, dynamic> _$GoalModelToJson(GoalModel instance) => <String, dynamic>{
      'id': instance.id,
      'calorieGoal': instance.calorieGoal,
      'userID': instance.userID,
    };
