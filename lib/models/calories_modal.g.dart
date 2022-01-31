// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'calories_modal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaloriesModel _$CaloriesModelFromJson(Map<String, dynamic> json) =>
    CaloriesModel(
      json['id'] as String,
      json['calories'] as int,
      json['createdAt'] as DateTime,
      json['userID'] as String,
    );

Map<String, dynamic> _$CaloriesModelToJson(CaloriesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'calories': instance.calories,
      'createdAt': instance.createdAt.toIso8601String(),
      'userID': instance.userID,
    };
