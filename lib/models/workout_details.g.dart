// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkoutDetails _$WorkoutDetailsFromJson(Map<String, dynamic> json) {
  return WorkoutDetails(
    (json['exerciseList'] as List)
        ?.map((e) => e == null
            ? null
            : ExerciseModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    title: json['title'] as String,
    trainer: json['trainer'] as String,
    athlete: json['athlete'] as String,
    modsList: (json['modsList'] as List)
        ?.map((e) => _$enumDecodeNullable(_$ModsEnumEnumMap, e))
        ?.toList(),
    workoutId: json['workoutId'] as String,
    duration: (json['duration'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$WorkoutDetailsToJson(WorkoutDetails instance) =>
    <String, dynamic>{
      'title': instance.title,
      'trainer': instance.trainer,
      'athlete': instance.athlete,
      'modsList': instance.modsList?.map((e) => _$ModsEnumEnumMap[e])?.toList(),
      'exerciseList': instance.exerciseList,
      'duration': instance.duration,
      'workoutId': instance.workoutId,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$ModsEnumEnumMap = {
  ModsEnum.plio: 'plio',
  ModsEnum.physio: 'physio',
  ModsEnum.fit: 'fit',
  ModsEnum.kids: 'kids',
  ModsEnum.silver: 'silver',
};
