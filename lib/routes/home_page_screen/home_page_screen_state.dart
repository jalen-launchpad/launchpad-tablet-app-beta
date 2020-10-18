import 'package:tabletapp/models/workout_details.dart';
import 'package:tabletapp/models/workout_metadata.dart';

class HomePageScreenState {
  final WorkoutMetadata sidebarClass;
  final WorkoutMetadata recommendedClass;
  final List<WorkoutMetadata> alternativeClasses;

  HomePageScreenState({
    this.recommendedClass,
    this.sidebarClass,
    this.alternativeClasses,
  });

  HomePageScreenState copyWith({
    WorkoutMetadata recommendedClass,
    WorkoutMetadata sidebarClass,
    List<WorkoutDetails> alternativeClasses,
  }) {
    return HomePageScreenState(
      recommendedClass: recommendedClass ?? this.recommendedClass,
      sidebarClass: sidebarClass ?? this.sidebarClass,
      alternativeClasses: alternativeClasses ?? this.alternativeClasses,
    );
  }
}
