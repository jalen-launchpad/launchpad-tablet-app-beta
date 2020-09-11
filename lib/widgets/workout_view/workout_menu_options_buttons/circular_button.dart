import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onClick;

  CircularButton(
      {this.color, this.width, this.height, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(height),
      child: InkWell(
        onTap: onClick,
        enableFeedback: false,
        borderRadius: BorderRadius.circular(height),
        radius: height,
        child: Container(
          width: width,
          height: height,
          child: icon,
        ),
      ),
    );
  }
}
