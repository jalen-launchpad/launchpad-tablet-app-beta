// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseModel _$ExerciseModelFromJson(Map<String, dynamic> json) {
  return ExerciseModel(
    name: json['name'] as String,
    intensity: json['intensity'] as int,
  );
}

Map<String, dynamic> _$ExerciseModelToJson(ExerciseModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'intensity': instance.intensity,
    };
