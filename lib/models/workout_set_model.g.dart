// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_set_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutSetModel _$WorkoutSetModelFromJson(Map<String, dynamic> json) {
  return WorkoutSetModel(
    exerciseSetDefinition: json['exerciseSetDefinition'] == null
        ? null
        : ExerciseSetModel.fromJson(
            json['exerciseSetDefinition'] as Map<String, dynamic>),
    videoTimestamp: json['videoTimestamp'] as int,
    isRest: json['isRest'] as bool,
    videoEndTimestamp: json['videoEndTimestamp'] as int,
  );
}

Map<String, dynamic> _$WorkoutSetModelToJson(WorkoutSetModel instance) =>
    <String, dynamic>{
      'exerciseSetDefinition': instance.exerciseSetDefinition,
      'isRest': instance.isRest,
      'videoTimestamp': instance.videoTimestamp,
      'videoEndTimestamp': instance.videoEndTimestamp,
    };
