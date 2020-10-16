import 'package:tabletapp/models/workout_details.dart';

class HomePageScreenState {
  final WorkoutDetails sidebarClass;
  final WorkoutDetails recommendedClass;
  final List<WorkoutDetails> alternativeClasses;

  HomePageScreenState({
    this.recommendedClass,
    this.sidebarClass,
    this.alternativeClasses,
  });

  HomePageScreenState copyWith({
    WorkoutDetails recommendedClass,
    WorkoutDetails sidebarClass,
    List<WorkoutDetails> alternativeClasses,
  }) {
    return HomePageScreenState(
      recommendedClass: recommendedClass ?? this.recommendedClass,
      sidebarClass: sidebarClass ?? this.sidebarClass,
      alternativeClasses: alternativeClasses ?? this.alternativeClasses,
    );
  }
}
