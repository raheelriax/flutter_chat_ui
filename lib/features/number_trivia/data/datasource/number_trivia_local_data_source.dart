import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class NumberTriviaLocalDataSource {
  Future<NumberTriviaModel> getLastNumberTrivia();

  Future<bool> cacheNumberTrivia(NumberTriviaModel model);
}

const String LOCAL_CACHE_KEY = 'CACHED_NUMBER_TRIVIA';

class NumberTriviaLocalDataSourceImpl implements NumberTriviaLocalDataSource {
  final SharedPreferences cache;

  NumberTriviaLocalDataSourceImpl({@required this.cache});

  @override
  Future<bool> cacheNumberTrivia(NumberTriviaModel model) {
    return cache.setString(LOCAL_CACHE_KEY, json.encode(model.toJson()));
  }

  @override
  Future<NumberTriviaModel> getLastNumberTrivia() {
    final jsonString = cache.getString(LOCAL_CACHE_KEY);
    if (jsonString != null) {
      return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    }
    throw CacheException();
  }
}
