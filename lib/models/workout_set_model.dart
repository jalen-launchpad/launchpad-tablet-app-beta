import 'package:tabletapp/models/exercise_set_model.dart';

class WorkoutSetModel {
  final ExerciseSetModel exerciseSetDefinition;

  // Methodology that indicates what form corrections/cues to look for
  // when coaching.
  final CoachingMethodology coachingMethodology;

  // Methodology that indicates what to look for when scoring an exercise.
  final ScoringMethodology scoringMethodology;

  // Is this a rest period?
  final bool isRest;

  // Timestamp of the beginning of the set in
  // milliseconds since start of video.
  final int videoTimeStamp;

  // Length the set takes to complete in the video.
  final int videoDuration;

  WorkoutSetModel({
    this.exerciseSetDefinition,
    this.coachingMethodology,
    this.scoringMethodology,
    this.videoTimeStamp,
    this.isRest,
    this.videoDuration,
  });
}

// TODO(jalen): Come up with this. LOL.s
class CoachingMethodology {}

// TODO(jalen): Come up with this. LOL.
class ScoringMethodology {}
