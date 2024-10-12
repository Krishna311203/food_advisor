import 'package:flutter/material.dart';

class CircleWidget extends StatelessWidget {
  final double top;
  final double left;
  final double bottom;
  final double right;
  final double size;
  final List<Color> gradientColors;

  const CircleWidget({
    Key? key,
    this.top = 0,
    this.left = 0,
    this.bottom = 0,
    this.right = 0,
    required this.size,
    required this.gradientColors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 15,
              offset: Offset(5, 5), // Shadow position
            ),
          ],
        ),
      ),
    );
  }
}
