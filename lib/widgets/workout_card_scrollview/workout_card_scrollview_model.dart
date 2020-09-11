
import 'package:tabletapp/models/workout_details.dart';

// WorkoutCardScrollviewModel is a model that encapsulates all the relevant
// information that a WorkoutCardScrollview requires.

class WorkoutCardScrollviewModel {
  final List<WorkoutDetails> details;
  final String header;

  WorkoutCardScrollviewModel(this.details, this.header);
  
}