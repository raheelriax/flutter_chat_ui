import 'package:chat_ui/screens/home.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Let's Chat",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Color(0xFFFEF9EB),
          selectedRowColor: Color(0xFFFFEFEE)),
      home: Home(),
    );
  }
}
