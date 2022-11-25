// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';
class BmiResult extends StatelessWidget {
  final double result;
  final bool isMale;
  final int age;
  BmiResult({
    required this.result,
    required this.isMale,
    required this.age,
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI RESULT"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Gender: ${isMale?"Male":"Female"}",
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),),
            Text("Result: ${result.round()}",
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            ),
            Text("Age: $age",
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),),
          ],
        ),
      ),
    );
  }
}
