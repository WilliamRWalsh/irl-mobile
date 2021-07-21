// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calories_modal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaloriesModel _$CaloriesModelFromJson(Map<String, dynamic> json) {
  return CaloriesModel(
    json['id'] as String,
    json['calories'] as int,
    json['createdAt'] as String,
    json['userID'] as String,
  );
}

Map<String, dynamic> _$CaloriesModelToJson(CaloriesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'calories': instance.calories,
      'createdAt': instance.createdAt,
      'userID': instance.userID,
    };
