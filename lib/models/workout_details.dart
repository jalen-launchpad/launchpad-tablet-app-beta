
import 'package:tabletapp/enums/mods_enum.dart';

// WorkoutDetails is a model that encapsulates all the relevant
// information that a Workout requires to display on HomePage.

class WorkoutDetails {
  final String title;
  final String trainer;
  final String athlete;
  final List<ModsEnum> modsList;
  final String workoutId;

  WorkoutDetails({this.title, this.trainer, this.athlete, this.modsList, this.workoutId});
}