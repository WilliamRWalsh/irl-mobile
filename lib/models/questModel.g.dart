// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quest _$QuestFromJson(Map<String, dynamic> json) {
  return Quest(
    json['id'] as int,
    json['title'] as String,
  );
}

Map<String, dynamic> _$QuestToJson(Quest instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.name,
    };
