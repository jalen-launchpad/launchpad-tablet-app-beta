import 'package:tabletapp/enums/mods_enum.dart';
import 'package:tabletapp/widgets/body_composite/body_composite_model.dart';
import 'package:tabletapp/models/workout_details.dart';

import 'models/exercise_score_model.dart';
import 'models/exercise_set_model.dart';
import 'models/user_model.dart';
import 'widgets/workout_view/metrics/leaderboard/leaderboard_entry_model.dart';
import 'widgets/workout_view/metrics/leaderboard/leaderboard_model.dart';

class PlaceholderValues {
  static List<MuscleFatiguePoint> fatiguePoints = [
    MuscleFatiguePoint()
      ..bodyPart = BodyPartEnum.rightArm
      ..fatigueLevel = FatigueLevelEnum.notFatigued,
    MuscleFatiguePoint()
      ..bodyPart = BodyPartEnum.leftArm
      ..fatigueLevel = FatigueLevelEnum.notFatigued,
    MuscleFatiguePoint()
      ..bodyPart = BodyPartEnum.rightShoulder
      ..fatigueLevel = FatigueLevelEnum.slightlyFatigued,
    MuscleFatiguePoint()
      ..bodyPart = BodyPartEnum.leftShoulder
      ..fatigueLevel = FatigueLevelEnum.slightlyFatigued,
    MuscleFatiguePoint()
      ..bodyPart = BodyPartEnum.rightLeg
      ..fatigueLevel = FatigueLevelEnum.veryFatigued,
    MuscleFatiguePoint()
      ..bodyPart = BodyPartEnum.leftLeg
      ..fatigueLevel = FatigueLevelEnum.veryFatigued,
    MuscleFatiguePoint()
      ..bodyPart = BodyPartEnum.core
      ..fatigueLevel = FatigueLevelEnum.extremelyFatigued,
  ];

  static BodyCompositeModel bodyCompositeModel = BodyCompositeModel()
    ..muscleFatiguePoints = fatiguePoints;

  static List<WorkoutDetails> workoutCardList = [
    WorkoutDetails(
        title: "Vertical Jump Plyos",
        trainer: "Doug Goldstein",
        athlete: "Jalen Gabbidon",
        modsList: [ModsEnum.plio, ModsEnum.fit],
        workoutId: '123456'),
    WorkoutDetails(
        title: "Upper Body Crush",
        trainer: "Doug Goldstein",
        athlete: "Jason Abromaitis",
        modsList: [ModsEnum.plio, ModsEnum.fit],
        workoutId: '234567'),
    WorkoutDetails(
        title: "Fun with Spongebob!",
        trainer: "Spongebob Squarepants",
        athlete: "Jalen Gabbidon",
        modsList: [ModsEnum.kids],
        workoutId: '345678'),
    WorkoutDetails(
        title: "Lateral Quickness Series Day 3",
        trainer: "Ann Abromaitis",
        athlete: "Jack and Ellie Abromaitis",
        modsList: [ModsEnum.plio, ModsEnum.kids],
        workoutId: '456789'),
    WorkoutDetails(
        title: "Vertical Jump Plyos",
        trainer: "Doug Goldstein",
        athlete: "Jalen Gabbidon",
        modsList: [ModsEnum.plio, ModsEnum.fit],
        workoutId: '123456'),
    WorkoutDetails(
        title: "Upper Body Crush",
        trainer: "Doug Goldstein",
        athlete: "Jason Abromaitis",
        modsList: [ModsEnum.plio, ModsEnum.fit],
        workoutId: '234567'),
    WorkoutDetails(
        title: "Fun with Spongebob!",
        trainer: "Spongebob Squarepants",
        athlete: "Jalen Gabbidon",
        modsList: [ModsEnum.kids],
        workoutId: '345678'),
    WorkoutDetails(
        title: "Lateral Quickness Series Day 3",
        trainer: "Ann Abromaitis",
        athlete: "Jack and Ellie Abromaitis",
        modsList: [ModsEnum.plio, ModsEnum.kids],
        workoutId: '456789'),
  ];
  var leaderboard = LeaderboardModel(
      userPosition: 0,
      nextScoreToBeat: 5,
      userEntry: LeaderboardEntryModel(
          user: UserModel(username: 'gabbyyyy'),
          score: ExerciseScoreModel(goodReps: 0, badReps: 0)),
      leaderboardEntries: [
        LeaderboardEntryModel(
            user: UserModel(
                firstName: 'Ellie',
                lastName: 'Abromaitis',
                username: 'no_knucks'),
            score: ExerciseScoreModel(
              exerciseSetDefinition: ExerciseSetModel(
                  exerciseName: 'Split Squat', targetReps: 10, isRest: false),
              value: 5,
              goodReps: 0,
              badReps: 5,
            )),
        LeaderboardEntryModel(
            user: UserModel(
                firstName: 'Jack',
                lastName: 'Abromaitis',
                username: 'beyblades!!'),
            score: ExerciseScoreModel(
                exerciseSetDefinition: ExerciseSetModel(
                    exerciseName: 'Split Squat', targetReps: 10, isRest: false),
                value: 7,
                goodReps: 2,
                badReps: 5)),
        LeaderboardEntryModel(
            user: UserModel(
                firstName: 'Doug', lastName: 'Goldstein', username: 'dougie'),
            score: ExerciseScoreModel(
              exerciseSetDefinition: ExerciseSetModel(
                  exerciseName: 'Split Squat', targetReps: 10, isRest: false),
              value: 20,
              goodReps: 10,
              badReps: 0,
            )),
        LeaderboardEntryModel(
            user: UserModel(
                firstName: 'Ann',
                lastName: 'Abromaitis',
                username: 'killa_strotha'),
            score: ExerciseScoreModel(
                exerciseSetDefinition: ExerciseSetModel(
                    exerciseName: 'Split Squat', targetReps: 10, isRest: false),
                value: 30,
                goodReps: 2,
                badReps: 10)),
        LeaderboardEntryModel(
            user: UserModel(
                firstName: 'Lee',
                lastName: 'Goldstein',
                username: 'lee_loves_me'),
            score: ExerciseScoreModel(
                exerciseSetDefinition: ExerciseSetModel(
                    exerciseName: 'Split Squat', targetReps: 10, isRest: false),
                value: 66,
                goodReps: 10,
                badReps: 3)),
        LeaderboardEntryModel(
            user: UserModel(
                firstName: 'Candice',
                lastName: 'Goldstein',
                username: 'masta_chef'),
            score: ExerciseScoreModel(
                exerciseSetDefinition: ExerciseSetModel(
                    exerciseName: 'Split Squat', targetReps: 10, isRest: false),
                value: 130,
                goodReps: 7,
                badReps: 10)),
        LeaderboardEntryModel(
            user: UserModel(
                firstName: 'Brooks',
                lastName: 'Goldstein',
                username: 'so_cute'),
            score: ExerciseScoreModel(
              exerciseSetDefinition: ExerciseSetModel(
                  exerciseName: 'Split Squat', targetReps: 10, isRest: false),
              value: 1000,
              goodReps: 5,
              badReps: 15,
            )),
      ]);
}
