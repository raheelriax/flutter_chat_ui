import 'dart:convert';
import 'package:matcher/matcher.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  NumberTriviaLocalDataSourceImpl numberTriviaLocalDataSource;
  MockSharedPreferences sharedPreferences;

  setUp(() {
    sharedPreferences = MockSharedPreferences();
    numberTriviaLocalDataSource =
        NumberTriviaLocalDataSourceImpl(cache: sharedPreferences);
  });

  group('Get Last Number Trivia', () {
    final numberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia_cached.json')));
    test('Should return number trivia from cache when there is one', () async {
      when(sharedPreferences.getString(any))
          .thenReturn(fixture('trivia_cached.json'));
      final result = await numberTriviaLocalDataSource.getLastNumberTrivia();

      verify(sharedPreferences.getString(LOCAL_CACHE_KEY));
      expect(result, numberTriviaModel);
    });

    test('Should throw cached exception when cache is empty', () async {
      when(sharedPreferences.getString(any)).thenReturn(null);
      final call = numberTriviaLocalDataSource.getLastNumberTrivia;
      expect(() =>  call(), throwsA(TypeMatcher<CacheException>()));
    });
  });

  group('Cache Number Trivia', () {
    final numberTrivia = NumberTriviaModel(number: 1, text: 'test trivia');
    test('Should call shared preferences to cache the data', () async {
      numberTriviaLocalDataSource.cacheNumberTrivia(numberTrivia);
      verify(sharedPreferences.setString(
          LOCAL_CACHE_KEY, json.encode(numberTrivia.toJson())));
    });
  });
}
