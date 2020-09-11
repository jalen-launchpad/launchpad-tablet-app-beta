import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/models/exercise_score_model.dart';
import 'package:tabletapp/models/user_model.dart';
import 'package:tabletapp/widgets/workout_view/metrics/exercise_leaderboard/exercise_leaderboard_model.dart';

import 'exercise_leaderboard_entry.dart';
import 'exercise_leaderboard_entry_model.dart';

// @params
// User user
// List<ExerciseLeaderboardEntryModel> currentExerciseLeaderboards

class ExerciseLeaderboard extends StatefulWidget {
  final ExerciseLeaderboardModel currentExerciseLeaderboard;

  ExerciseLeaderboard({
    this.currentExerciseLeaderboard,
  });

  static const double workoutLeaderboardHeight = 150;
  static const double workoutLeaderboardWidth = 400;

  @override
  _ExerciseLeaderboardState createState() => _ExerciseLeaderboardState(
        currentExerciseLeaderboard: this.currentExerciseLeaderboard,
      );
}

class _ExerciseLeaderboardState extends State<ExerciseLeaderboard> {
  // Low number => Low position
  ExerciseLeaderboardModel currentExerciseLeaderboard;
  // Every exercise user starts from 0, therefore the last position.
  _ExerciseLeaderboardState({this.currentExerciseLeaderboard});

  static const double workoutLeaderboardOpacity = 0.75;
  static const double borderRadius = 30;

  // Provides -> ExerciseLeaderboardModel (to ExerciseLeaderboardEntry)
  // Consumes -> ExerciseLeaderboardEntryModel (from WorkoutVideoScreen)
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<ExerciseLeaderboardEntryModel>(
          builder: (context, model, child) {
        if (model.score.getValue >=
            currentExerciseLeaderboard.nextScoreToBeat) {
          currentExerciseLeaderboard.updateUserPosition(model.score.getValue);
        }
        return Container(
          width: ExerciseLeaderboard.workoutLeaderboardWidth,
          height: ExerciseLeaderboard.workoutLeaderboardHeight,
          decoration: BoxDecoration(
            color: ColorConstants.launchpadPrimaryBlack
                .withOpacity(workoutLeaderboardOpacity),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: ChangeNotifierProvider<ExerciseLeaderboardModel>(
            create: (context) => this.currentExerciseLeaderboard,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                currentExerciseLeaderboard.getAbove() == null
                    ? Container(
                        height: ExerciseLeaderboardEntry.height,
                      )
                    : ExerciseLeaderboardEntry(
                        exerciseLeaderboardEntryModel:
                            currentExerciseLeaderboard.getAbove(),
                        isAbove: true,
                        // TODO - fill with ExerciseLeaderboardEntryModel
                      ),
                ExerciseLeaderboardEntry(
                  exerciseLeaderboardEntryModel: model,
                  isUser: true,
                  // TODO - fill with ExerciseLeaderboardEntryModel
                ),
                currentExerciseLeaderboard.getBelow() == null
                    ? Container(
                        height: ExerciseLeaderboardEntry.height,
                      )
                    : ExerciseLeaderboardEntry(
                        exerciseLeaderboardEntryModel:
                            currentExerciseLeaderboard.getBelow(),
                        isBelow: true,
                        // TODO - fill with ExerciseLeaderboardEntryModel
                      ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
