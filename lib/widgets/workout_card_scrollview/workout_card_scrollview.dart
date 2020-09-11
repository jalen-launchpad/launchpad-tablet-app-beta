import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tabletapp/widgets/workout_card_scrollview/workout_card_scrollview_model.dart';
import 'package:tabletapp/widgets/workout_card/workout_card.dart';

// A scrollview that contains Workout Cards for a particular
// genre/category/header.

// @params
// WorkoutCardScrollviewModel model

class WorkoutCardScrollview extends StatelessWidget {
  static const height = WorkoutCard.height + 65;

  static const headerPadding = EdgeInsets.only(left: 25, bottom: 10);

  static const headerTextStyle = TextStyle(fontSize: 30);

  static const workoutCardPadding = EdgeInsets.only(left: 0, right: 25);

  static const workoutCardSeparatorBuilder = Divider(indent: 20, endIndent: 20);

  final WorkoutCardScrollviewModel model;
  final List<Widget> workoutCardList;

  WorkoutCardScrollview(this.model)
      : this.workoutCardList = convertToWorkoutCardList(model);

  // Takes a WorkoutCardScrollviewModel and returns a list of WorkoutCards
  static List<Widget> convertToWorkoutCardList(
      WorkoutCardScrollviewModel model) {
    List<Widget> list = [];
    model.details.forEach((workoutDetail) {
      list.add(WorkoutCard(workoutDetail));
    });
    return list;
  }

  // Builds the WorkoutCardScrollview widget.
  Widget getWorkoutCardScrollview() {
    return SizedBox(
      height: height,
      child: Column(
        children: [
          // This is the header of the scrollview.
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  padding: headerPadding,
                  child: Text(this.model.header,
                      textAlign: TextAlign.start, style: headerTextStyle)),
            ],
          ),
          // This is the horizontal scrollview.
          SizedBox(
            height: WorkoutCard.height,
            child: ListView.separated(
              padding: workoutCardPadding,
              itemCount: workoutCardList.length,
              itemBuilder: (BuildContext context, int index) =>
                  workoutCardList[index],
              separatorBuilder: (BuildContext context, int index) =>
                  workoutCardSeparatorBuilder,
              scrollDirection: Axis.horizontal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return getWorkoutCardScrollview();
  }
}
