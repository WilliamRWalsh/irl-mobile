import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Quest {
  final int id;
  final String title;

  Quest({
    this.id,
    this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}
