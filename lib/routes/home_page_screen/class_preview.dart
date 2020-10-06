import 'package:flutter/material.dart';
import 'package:tabletapp/constants/colors.dart';

class ClassPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Stack(
        children: [
          // TODO(jalen): Add background image here

          // *************
          // Bakcground Photo
          // *************
          Positioned(
              top: 0,
              left: 0,
              child: Image.asset("assets/images/backgroundPlaceholder.png",
                  width: MediaQuery.of(context).size.width * 2 / 3)),

          // *************
          // Launchpad Corner Logo
          // *************
          Positioned(
            child: Image.asset('assets/images/homePageLogo.png', height: 25),
            left: 30,
            top: 50,
          ),

          // *************
          // Class Preview Title
          // *************
          Positioned(
            left: 30,
            bottom: 60,
            child: Text(
              // TODO(jalen): Replace with real class preview value
              "Shoulder Blast",
              style: TextStyle(
                color: ColorConstants.launchpadPrimaryWhite,
                fontSize: 80,
              ),
            ),
          ),
          
          // *************
          // Black gradient effect from bottom of screen.
          // *************
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 9,
                  width: MediaQuery.of(context).size.width -
                      MediaQuery.of(context).size.width / 3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomLeft,
                      end: Alignment.topLeft,
                      colors: [
                        ColorConstants.launchpadPrimaryBlack,
                        ColorConstants.launchpadPrimaryBlack.withOpacity(0)
                      ], // Blueish to Opaque
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
