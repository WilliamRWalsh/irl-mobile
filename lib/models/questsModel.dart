import 'package:json_annotation/json_annotation.dart';

part 'quest.g.dart';

@JsonSerializable()
class Quest {
  Quest(this.id, this.name);

  final int id;

  @JsonKey(name: 'title')
  final String name;

  factory Quest.fromJson(Map<String, dynamic> json) => _$QuestFromJson(json);

  Map<String, dynamic> toJson() => _$QuestToJson(this);
}
