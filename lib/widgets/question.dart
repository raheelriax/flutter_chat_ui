import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String statement;

  Question(this.statement);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        statement,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
