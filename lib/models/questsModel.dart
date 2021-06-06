import 'package:irl_mobile/models/questModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'questsModel.g.dart';

@JsonSerializable()
class Quests {
  Quests(this.quests);

  final List<Quest> quests;

  // factory Quests.fromJson(List<dynamic> json) => _$QuestsFromJson(json);

  Map<String, dynamic> toJson() => _$QuestsToJson(this);
}
