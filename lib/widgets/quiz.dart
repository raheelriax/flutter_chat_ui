import 'package:first_app/widgets/question.dart';
import 'package:flutter/material.dart';

import 'answer.dart';

class Quiz extends StatelessWidget {
  final int questionIndex;
  final Function answerQuestion;

  final List<Map<String, Object>> questions;

  Quiz({this.questionIndex, this.answerQuestion, this.questions});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Question(
        questions[questionIndex]['question'],
      ),
      ...(questions[questionIndex]['answers'] as List<String>).map((answer) {
        return Answer(
          onPressed: () => answerQuestion(
              questions[questionIndex]['correctAnswer'] == answer),
          statement: answer,
        );
      }).toList(),
    ]);
    ;
  }
}
