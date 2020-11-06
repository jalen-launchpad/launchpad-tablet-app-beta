// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leaderboard_entry_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaderboardEntryModel _$LeaderboardEntryModelFromJson(
    Map<String, dynamic> json) {
  return LeaderboardEntryModel(
    user: json['user'] == null
        ? null
        : UserModel.fromJson(json['user'] as Map<String, dynamic>),
    exerciseSetDefinition: json['exerciseSetDefinition'] == null
        ? null
        : ExerciseSetModel.fromJson(
            json['exerciseSetDefinition'] as Map<String, dynamic>),
    score: json['score'] == null
        ? null
        : ExerciseScoreModel.fromJson(json['score'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LeaderboardEntryModelToJson(
        LeaderboardEntryModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'exerciseSetDefinition': instance.exerciseSetDefinition,
      'score': instance.score,
    };
