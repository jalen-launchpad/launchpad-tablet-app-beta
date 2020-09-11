import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/widgets/workout_view/workout_menu_options_buttons/circular_button.dart';
import 'package:video_player/video_player.dart';

class WorkoutMenuOptionsButtons extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  WorkoutMenuOptionsButtons({this.videoPlayerController});
  @override
  _WorkoutMenuOptionsButtonsState createState() =>
      _WorkoutMenuOptionsButtonsState(
          videoPlayerController: videoPlayerController);
}

class _WorkoutMenuOptionsButtonsState extends State<WorkoutMenuOptionsButtons> {
  static const double containerHeight = 600;
  static const double containerWidth = 120;
  static const double animatedPositionLeftOffset = 10;

  double menuIconLocation = 30;
  double closeIconLocation = 30;
  double pauseIconLocation = 30;
  double previousIconLocation = 30;
  double buttonSize = 80;
  IconData pausePlayIcon = Icons.pause;

  final VideoPlayerController videoPlayerController;

  _WorkoutMenuOptionsButtonsState({this.videoPlayerController});

  void togglePause() {
    if (pausePlayIcon == Icons.pause) {
      pausePlayIcon = Icons.play_arrow;
      videoPlayerController.pause();
    } else {
      pausePlayIcon = Icons.pause;
      videoPlayerController.play();
    }
  }

  void toggleMenu() {
    setState(() {
      if (closeIconLocation == menuIconLocation) {
        closeIconLocation = menuIconLocation + buttonSize + 40;
        pauseIconLocation = closeIconLocation + buttonSize + 20;
        previousIconLocation = pauseIconLocation + buttonSize + 20;
      } else {
        closeIconLocation = menuIconLocation;
        pauseIconLocation = menuIconLocation;
        previousIconLocation = menuIconLocation;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: containerWidth,
        height: containerHeight,
        child: Stack(
          children: [
            // Skip to previous exercise
            AnimatedPositioned(
              left: animatedPositionLeftOffset,
              bottom: previousIconLocation,
              duration: Duration(milliseconds: 300),
              child: CircularButton(
                  icon: Icon(
                    Icons.skip_previous,
                    color: ColorConstants.launchpadSecondaryLightBlue,
                  ),
                  height: buttonSize,
                  width: buttonSize,
                  color: ColorConstants.launchpadPrimaryBlue,
                  onClick: () => {}),
            ),
            // Pause playback
            AnimatedPositioned(
              left: animatedPositionLeftOffset,
              bottom: pauseIconLocation,
              duration: Duration(milliseconds: 300),
              child: CircularButton(
                icon: Icon(
                  pausePlayIcon,
                  color: ColorConstants.launchpadSecondaryLightBlue,
                ),
                height: buttonSize,
                width: buttonSize,
                color: ColorConstants.launchpadPrimaryBlue,
                onClick: () {
                  setState(() {
                    togglePause();
                  });
                },
              ),
            ),
            // Exit Class
            AnimatedPositioned(
              left: animatedPositionLeftOffset,
              bottom: closeIconLocation,
              duration: Duration(milliseconds: 300),
              child: CircularButton(
                  icon: Icon(
                    Icons.close,
                    color: ColorConstants.launchpadPrimaryWhite,
                  ),
                  height: buttonSize,
                  width: buttonSize,
                  color: Colors.red,
                  onClick: () => {}),
            ),
            // Toggle menu buttons
            AnimatedPositioned(
              bottom: menuIconLocation - 1,
              duration: Duration(milliseconds: 300),
              child: CircularButton(
                icon: Icon(
                  Icons.menu,
                  color: ColorConstants.launchpadPrimaryWhite,
                ),
                height: buttonSize + 20,
                width: buttonSize + 20,
                color: ColorConstants.launchpadMenuButtonBlue,
                onClick: toggleMenu,
              ),
            ),
          ],
        ));
  }
}
