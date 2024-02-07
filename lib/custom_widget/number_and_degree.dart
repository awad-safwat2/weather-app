import 'package:flutter/material.dart';

class NumberAndDegree extends StatelessWidget {
  const NumberAndDegree({
    super.key,
    required this.tempNumber,
    required this.degreeSize,
    required this.numberSize,
  });

  final String tempNumber;
  final double numberSize;
  final double degreeSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: tempNumber.toString(),
        style: TextStyle(
          fontSize: numberSize,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        children: [
          TextSpan(
            text: '°',
            style: TextStyle(
              fontSize: degreeSize,
              textBaseline: TextBaseline.alphabetic,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
