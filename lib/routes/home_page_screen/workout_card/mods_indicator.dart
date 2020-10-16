import 'package:flutter/widgets.dart';
import 'package:tabletapp/constants/colors.dart';
import 'package:tabletapp/constants/size_config.dart';
import 'package:tabletapp/enums/mods_enum.dart';

// The indicator in bottom right of WorkoutCard telling users which
// mod the class requires.

// @params
// List<ModsEnum> modsList

class ModsInidcator extends StatelessWidget {
  static double height = SizeConfig.blockSizeVertical * 3;

  static double width = SizeConfig.blockSizeHorizontal * 5;

  static const BorderRadius borderRadius =
      BorderRadius.all(Radius.circular(20));

  static SizedBox sizedBoxSpacer = SizedBox(width: SizeConfig.blockSizeHorizontal * 0.5, height: SizeConfig.blockSizeVertical * 2);

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
              color: ModsEnumToColorMap[mod], borderRadius: borderRadius),
          child: Center(
            child: Text(
              ModsEnumToStringMap[mod],
              style: TextStyle(
                color: ColorConstants.launchpadPrimaryWhite,
                fontFamily: 'Jost',
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.blockSizeHorizontal * 1.2,
              ),
            ),
          ),
        )
      ]);
    });
    modListWidgets.removeAt(0);
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
