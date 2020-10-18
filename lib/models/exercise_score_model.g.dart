// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_score_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseScoreModel _$ExerciseScoreModelFromJson(Map<String, dynamic> json) {
  return ExerciseScoreModel(
    exerciseSetDefinition: json['exerciseSetDefinition'] == null
        ? null
        : ExerciseSetModel.fromJson(
            json['exerciseSetDefinition'] as Map<String, dynamic>),
    value: json['value'] as int,
    goodReps: json['goodReps'] as int,
    badReps: json['badReps'] as int,
  );
}

Map<String, dynamic> _$ExerciseScoreModelToJson(ExerciseScoreModel instance) =>
    <String, dynamic>{
      'exerciseSetDefinition': instance.exerciseSetDefinition,
      'goodReps': instance.goodReps,
      'badReps': instance.badReps,
      'value': instance.value,
    };
