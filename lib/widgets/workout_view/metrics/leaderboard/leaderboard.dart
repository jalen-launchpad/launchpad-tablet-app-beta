import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tabletapp/routes/workout_video_screen/workout_video_screen_model.dart';
import 'leaderboard_entry.dart';
import 'leaderboard_entry_model.dart';
import 'leaderboard_model.dart';

// @params
// User user
// List<LeaderboardEntryModel> currentLeaderboards

class Leaderboard extends StatefulWidget {
  final LeaderboardModel currentLeaderboard;

  Leaderboard({
    this.currentLeaderboard,
  });

  static const double workoutLeaderboardHeight = 150;
  static const double workoutLeaderboardWidth = 300;

  @override
  _LeaderboardState createState() => _LeaderboardState(
        currentLeaderboard: this.currentLeaderboard,
      );
}

class _LeaderboardState extends State<Leaderboard> {
  // Low number => Low position
  LeaderboardModel currentLeaderboard;
  // Every exercise user starts from 0, therefore the last position.
  _LeaderboardState({this.currentLeaderboard});

  static const double workoutLeaderboardOpacity = 0.75;
  static const double borderRadius = 30;

  // Provides -> LeaderboardModel (to LeaderboardEntry)
  // Consumes -> LeaderboardEntryModel (from WorkoutVideoScreen)
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StoreConnector<WorkoutVideoScreenModel, LeaderboardModel>(
          converter: (store) => store
              .state.leaderboards[store.state.currentExerciseIndex],
          builder: (context, model) {
            currentLeaderboard = model;
            return Container(
              width: Leaderboard.workoutLeaderboardWidth,
              height: Leaderboard.workoutLeaderboardHeight,
              decoration: BoxDecoration(
                color: ColorConstants.launchpadPrimaryBlack
                    .withOpacity(workoutLeaderboardOpacity),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  currentLeaderboard.getAbove() == null
                      ? Container(
                          height: LeaderboardEntry.height,
                        )
                      : LeaderboardEntry(
                          exerciseLeaderboardEntryModel:
                              currentLeaderboard.getAbove(),
                          isAbove: true,
                          // TODO - fill with LeaderboardEntryModel
                        ),
                  LeaderboardEntry(
                    exerciseLeaderboardEntryModel: model.userEntry,
                    isUser: true,
                    // TODO - fill with LeaderboardEntryModel
                  ),
                  currentLeaderboard.getBelow() == null
                      ? Container(
                          height: LeaderboardEntry.height,
                        )
                      : LeaderboardEntry(
                          exerciseLeaderboardEntryModel:
                              currentLeaderboard.getBelow(),
                          isBelow: true,
                          // TODO - fill with LeaderboardEntryModel
                        ),
                ],
              ),
            );
          }),
    );
  }
}

