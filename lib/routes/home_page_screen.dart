import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/widgets/workout_card_scrollview/workout_card_scrollview_model.dart';
import 'package:tabletapp/models/workout_details.dart';
import 'package:tabletapp/placeholder_values.dart';
import 'package:tabletapp/widgets/body_composite/body_composite.dart';
import 'package:tabletapp/widgets/workout_card_scrollview/workout_card_scrollview.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  static const Padding titleContainerPadding =
      Padding(padding: EdgeInsets.only(top: 20));
  static const Divider scrollviewDivider =
      Divider(thickness: 2, color: ColorConstants.launchpadPrimaryBlue);
  static const EdgeInsets listViewPadding = EdgeInsets.only(left: 0);

  @override
  Widget build(BuildContext context) {
    // *** This is a temporary placeholder ***
    List<WorkoutDetails> details = PlaceholderValues.workoutCardList;
    List<WorkoutDetails> details2 = PlaceholderValues.workoutCardList;
    List<WorkoutDetails> details3 = PlaceholderValues.workoutCardList;
    details2.shuffle();
    details2.shuffle();
    List<WorkoutCardScrollview> scrollview = [
      WorkoutCardScrollview(
          WorkoutCardScrollviewModel(details, 'Suggested for you')),
      WorkoutCardScrollview(
          WorkoutCardScrollviewModel(details2, 'Past classes')),
      WorkoutCardScrollview(
        WorkoutCardScrollviewModel(
            details3, 'Classes featuring your favorite athletes'),
      )
    ];
    // *** This is a temporary placeholder ***

    return Scaffold(
      body: Container(
        color: Colors.grey[100],
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            BodyComposite(
              bodyCompositeModel: PlaceholderValues.bodyCompositeModel,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 300,
              child: ListView(
                padding: listViewPadding,
                scrollDirection: Axis.vertical,
                children: [
                  Container(
                    height: 600,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.white.withOpacity(0.5), BlendMode.dstATop),
                          image: AssetImage('assets/homepagemontage.gif'),
                          fit: BoxFit.fill),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 200,
                          left: 120,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    child: Image.asset(
                                        'assets/launchpadlogo.png')),
                                Text(
                                  "a u n c h p a d",
                                  style: TextStyle(
                                      fontSize: 64,
                                      color:
                                          ColorConstants.launchpadPrimaryBlue),
                                )
                              ]),
                        )
                      ],
                    ),
                  ),
                  titleContainerPadding,
                  // TODO: Dynamically add these
                  scrollview[0],
                  scrollviewDivider,
                  scrollview[1],
                  scrollviewDivider,
                  scrollview[2],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
