import 'package:flutter/material.dart';
import 'package:tabletapp/constants/size_config.dart';
import '../leaderboard.dart';
import 'interstitial_rest_leaderboard.dart';

class InterstitialRestMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Leaderboard(),
          Container(width: SizeConfig.blockSizeHorizontal * 4),
          InterstitialRestLeaderboard(),
        ],
      ),
    );
  }
}
