
import 'workout_details.dart';
import 'workout_set_model.dart';

class WorkoutMetadata {
  // Sorted by earliest appearance to latest appearance in video.
  final List<WorkoutSetModel> workoutSets;
  final List<WorkoutDetails> workoutDetails;
  // TODO(Jalen): Video stream information.

  WorkoutMetadata({this.workoutSets, this.workoutDetails});
}
