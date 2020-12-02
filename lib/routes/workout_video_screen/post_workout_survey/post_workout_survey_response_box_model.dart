import 'package:tabletapp/routes/workout_video_screen/post_workout_survey/post_workout_survey_response_box.dart';

class PostWorkoutSurveyResponseBoxModel {
  final int overall;
  final int instructor;
  final int fun;
  final int difficulty;

  PostWorkoutSurveyResponseBoxModel(
      this.overall, this.instructor, this.fun, this.difficulty);

  static PostWorkoutSurveyResponseBoxModel initialize() {
    return PostWorkoutSurveyResponseBoxModel(5, 5, 5, 5);
  }
}
