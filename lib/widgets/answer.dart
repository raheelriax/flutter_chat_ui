import 'dart:math';

import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function onPressed;
  final String statement;

  Answer({this.onPressed, this.statement});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        textColor: Colors.white,
        child: Text(statement),
        color: Colors.blueAccent,
        onPressed: onPressed,
      ),
    );
  }
}
