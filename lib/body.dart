import 'package:first_app/widgets/final-screen.dart';
import 'package:first_app/widgets/quiz.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int _currentQuestion = 0;
  int _score = 0;
  static const List<Map<String, Object>> _questions = const [
    {
      'question': 'What is your favourite show ?',
      'answers': ['GOT', 'Big Bang Theory', 'The Walking Dead', 'Suits'],
      'correctAnswer': 'GOT'
    },
    {
      'question': 'What is your favourite color?',
      'answers': ['Black', 'White', 'Blue', 'Cyan'],
      'correctAnswer': 'Blue'
    },
    {
      'question': 'What is your favourite movie ?',
      'answers': [
        'Shawshank Redemption',
        'The Godfather',
        'The Dark Knight',
        'Rockstar'
      ],
      'correctAnswer': 'Rockstar'
    },
  ];

  void _answerQuestion(bool correct) {
    setState(() {
      _currentQuestion = _currentQuestion + 1;
      if (correct) {
        _score++;
      }
      print(_currentQuestion);
    });
  }

  void goBack() {
    setState(() {
      _currentQuestion = 0;
      _score = 0;
    });
  }

  String get finalStatement {
    String greeting = "You'are good";
    if (_score == _questions.length) {
      greeting = "You're Awsome !";
    } else if (_score > 0) {
      greeting = 'You did good';
    } else {
      greeting = 'Better Luck Next Time';
    }
    greeting = "$greeting\n You've answered all questions.";
    return "$greeting\nYour Score is : $_score";
  }

  @override
  Widget build(BuildContext context) {
    final bool allAnswered = _currentQuestion == _questions.length;
    Widget activeScreen;
    if (allAnswered) {
      activeScreen = finalScreen(goBack: goBack, text: finalStatement);
    } else {
      activeScreen = Quiz(
          questionIndex: _currentQuestion,
          answerQuestion: _answerQuestion,
          questions: _questions);
    }

    return activeScreen;
  }
}
