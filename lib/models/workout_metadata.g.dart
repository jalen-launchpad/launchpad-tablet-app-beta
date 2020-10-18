// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutMetadata _$WorkoutMetadataFromJson(Map<String, dynamic> json) {
  return WorkoutMetadata(
    (json['workoutSets'] as List)
        ?.map((e) => e == null
            ? null
            : WorkoutSetModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['workoutDetails'] == null
        ? null
        : WorkoutDetails.fromJson(
            json['workoutDetails'] as Map<String, dynamic>),
    json['streamUri'] as String,
  );
}

Map<String, dynamic> _$WorkoutMetadataToJson(WorkoutMetadata instance) =>
    <String, dynamic>{
      'workoutSets': instance.workoutSets,
      'workoutDetails': instance.workoutDetails,
      'streamUri': instance.streamUri,
    };
