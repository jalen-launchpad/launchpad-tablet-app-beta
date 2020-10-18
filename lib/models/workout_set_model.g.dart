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
    videoTimeStamp: json['videoTimeStamp'] as int,
    isRest: json['isRest'] as bool,
    videoDuration: json['videoDuration'] as int,
  );
}

Map<String, dynamic> _$WorkoutSetModelToJson(WorkoutSetModel instance) =>
    <String, dynamic>{
      'exerciseSetDefinition': instance.exerciseSetDefinition,
      'isRest': instance.isRest,
      'videoTimeStamp': instance.videoTimeStamp,
      'videoDuration': instance.videoDuration,
    };
