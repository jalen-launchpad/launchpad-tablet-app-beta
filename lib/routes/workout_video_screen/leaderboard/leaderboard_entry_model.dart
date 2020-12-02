import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tabletapp/models/exercise_set_model.dart';
import 'package:tabletapp/models/exercise_score_model.dart';
import 'package:tabletapp/models/user_model.dart';

part 'leaderboard_entry_model.g.dart';

// A model that represents one entry in a leaderboard.
// Can be a launchpad leaderboard entry or the real user.
@JsonSerializable()
class LeaderboardEntryModel {
  final UserModel user;
  final ExerciseSetModel exerciseSetDefinition;
  ExerciseScoreModel score;

  LeaderboardEntryModel(
      {@required this.user,
      @required this.exerciseSetDefinition,
      @required this.score});
  factory LeaderboardEntryModel.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryModelFromJson(json);
  Map<String, dynamic> toJson() => _$LeaderboardEntryModelToJson(this);
}
