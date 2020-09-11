import 'package:flutter/widgets.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/enums/mods_enum.dart';

// The indicator in bottom right of WorkoutCard telling users which
// mod the class requires.

// @params
// List<ModsEnum> modsList

class ModsInidcator extends StatelessWidget {
  static const double height = 24;

  static const double width = 60;

  static const BorderRadius borderRadius =
      BorderRadius.all(Radius.circular(20));

  static const EdgeInsets containerPadding = EdgeInsets.fromLTRB(0, 0, 10, 5);

  static const SizedBox sizedBoxSpacer = SizedBox(width: 5, height: 10);

  final List<ModsEnum> modsList;

  ModsInidcator(this.modsList);

  List<Widget> convertModsListToWidgets() {
    List<Widget> modListWidgets = [];

    this.modsList.forEach((mod) {
      modListWidgets.addAll([
        sizedBoxSpacer,
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: ModsEnumToColorMap[mod],
              borderRadius:
                  borderRadius),
          child: Center(
            child: Text(
              ModsEnumToStringMap[mod],
              style: TextStyle(color: ColorConstants.launchpadPrimaryBlue),
            ),
          ),
        )
      ]);
    });
    return modListWidgets;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> modListWidgets = convertModsListToWidgets();
    // print(modListWidgets);
    return Container(
        child: Row(
      children: modListWidgets,
    ));
  }
}
