import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final int number = 1;
  final String text = 'trivia test';
  final numberTriviaModel = NumberTriviaModel(number: number, text: text);
  test('Should be a subclass of numbertrivia entity', () {
    expect(numberTriviaModel, isA<NumberTrivia>());
  });
  group('from JSON', () {
    test('Should return a valid model when JSON number is valid int', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('trivia.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, numberTriviaModel);
    });
    test('Should return a valid model when JSON number is double', () async {
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('trivia_double.json'));
      final result = NumberTriviaModel.fromJson(jsonMap);
      expect(result, numberTriviaModel);
    });
    test('Should return a valid Json from model', () async {
      final result = numberTriviaModel.toJson();
      expect(result, {'text': text, 'number': number});
    });
  });
}
