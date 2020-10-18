import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/models/workout_details.dart';
import 'package:tabletapp/models/workout_metadata.dart';
import 'package:tabletapp/routes/home_page_screen/home_page_screen_reducers.dart';
import 'package:tabletapp/routes/home_page_screen/home_page_screen_state.dart';
import 'package:tabletapp/routes/home_page_screen/selected_class_sidebar/selected_class_sidebar.dart';
import 'package:redux/redux.dart';
import 'class_preview.dart';
import 'workout_card/workout_card.dart';

class HomePageScreen extends StatefulWidget {
  final HomePageScreenState homePageScreenState;

  HomePageScreen(this.homePageScreenState);

  @override
  _HomePageScreenState createState() =>
      _HomePageScreenState(this.homePageScreenState);
}

class _HomePageScreenState extends State<HomePageScreen> {
  final Store<HomePageScreenState> store;
  final HomePageScreenState homePageScreenState;
  _HomePageScreenState(this.homePageScreenState)
      : store = Store(rootReducer, initialState: homePageScreenState);

  List<Widget> buildAlternativeClassesGrid(
      List<WorkoutMetadata> workoutMetadata) {
    // print(workoutMetadata.length);
    // Get how many rows we need.
    // If there's 5 workouts, 2 rows (3 -> 2)
    // If there's 11 workouts, 4 rows (3 -> 3 -> 3 -> 2)
    int numRows = (workoutMetadata.length / 3).ceil();
    // print(numRows);
    List<Widget> grid = [];
    for (int x = 0; x < numRows; x++) {
      // Initialize this row with one single workout card
      List<Widget> row;
      if (x == numRows - 1) {
        row = [
          WorkoutCard(store, workoutMetadata[(x * 3)]),
        ];
        //print("x * 3 + 1");
        //print((x * 3) + 1);
        //print(workoutMetadata.length);
        // If there's 2 cards on this row, add it.
        if ((x * 3) + 1 != workoutMetadata.length) {
          row.add(WorkoutCard(store, workoutMetadata[(x * 3) + 1]));
          // If there's 3 cards on this row, add it.
          if ((x * 3) + 2 != workoutMetadata.length) {
            row.add(WorkoutCard(store, workoutMetadata[(x * 3) + 2]));
          }
        }
      } else {
        row = [
          WorkoutCard(store, workoutMetadata[(x * 3)]),
          WorkoutCard(store, workoutMetadata[(x * 3) + 1]),
          WorkoutCard(store, workoutMetadata[(x * 3) + 2]),
        ];
      }
      while (row.length != 3) {
        row.add(
          Container(width: WorkoutCard.width, height: WorkoutCard.height),
        );
      }
      print(row);
      grid.add(Container(
        padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 3,
          right: SizeConfig.blockSizeHorizontal * 3,
          bottom: SizeConfig.blockSizeVertical * 5,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: row,
        ),
      ));
    }

    return grid;
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<HomePageScreenState>(
      store: store,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Stack(
            children: [
              Container(
                width: SizeConfig.blockSizeHorizontal * 67,
                child: ListView(children: [
                  StoreConnector<HomePageScreenState, WorkoutMetadata>(
                    builder: (context, workoutMetadata) => Container(
                      child:
                          ClassPreview(workoutMetadata, store),
                      height: SizeConfig.blockSizeVertical * 80,
                    ),
                    converter: (store) => store.state.recommendedClass,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 3,
                      top: SizeConfig.blockSizeVertical * 5,
                      bottom: SizeConfig.blockSizeVertical * 5,
                    ),
                    child: Text("Other Workout Options",
                        style: TextStyle(
                            color: ColorConstants.launchpadPrimaryWhite,
                            fontSize: SizeConfig.blockSizeHorizontal * 1.2)),
                  ),
                  ...buildAlternativeClassesGrid(
                      store.state.alternativeClasses),
                ]),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: SelectedClassSidebar(),
                  width: SizeConfig.blockSizeHorizontal * 33,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
