// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'questsModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quests _$QuestsFromJson(Map<String, dynamic> json) {
  return Quests(
    (json['quests'] as List)
        ?.map(
            (e) => e == null ? null : Quest.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$QuestsToJson(Quests instance) => <String, dynamic>{
      'quests': instance.quests,
    };
