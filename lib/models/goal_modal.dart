import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'goal_modal.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class GoalModel {
  GoalModel(this.id, this.calorieGoal, this.userID);

  String id;
  int calorieGoal;
  String userID;

  /// A necessary factory constructor for creating a new Goal instance
  /// from a map. Pass the map to the generated `_$GoalFromJson()` constructor.
  /// The constructor is named after the source class, in this case, Goal.
  factory GoalModel.fromJson(Map<String, dynamic> json) =>
      _$GoalModelFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$GoalModelToJson`.
  Map<String, dynamic> toJson() => _$GoalModelToJson(this);
}
