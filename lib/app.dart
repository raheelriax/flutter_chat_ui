import 'package:first_app/body.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My App'),
        ),
        body: new Body(),
      ),
    );
  }
}
