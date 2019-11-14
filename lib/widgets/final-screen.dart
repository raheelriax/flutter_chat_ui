import 'package:flutter/material.dart';

Widget finalScreen({Function goBack, String text = 'All Answered'}) {
  return Center(
      child: Column(
    children: <Widget>[
      Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30),
      ),
      FlatButton.icon(
        icon: Icon(Icons.arrow_back_ios),
        label: Text('Go Back !'),
        splashColor: Colors.orange,
        textColor: Colors.white,
        color: Colors.cyan,
        onPressed: goBack,
      )
    ],
  ));
}
