import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/error/exceptions.dart';
import 'package:number_trivia/core/error/failure.dart';
import 'package:number_trivia/core/platform/network_info.dart';
import 'package:number_trivia/features/number_trivia/data/datasource/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/datasource/number_trivia_remote_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:number_trivia/features/number_trivia/data/respositories/number_trivia_repository_impl.dart';

class MockLocalDataSource extends Mock implements NumberTriviaLocalDataSource {}

class MockRemoteDataSource extends Mock
    implements NumberTriviaRemoteDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  NumberTriviaRepositoryImpl repository;
  MockLocalDataSource localDataSource;
  MockRemoteDataSource remoteDataSource;
  MockNetworkInfo networkInfo;

  setUp(() {
    localDataSource = MockLocalDataSource();
    remoteDataSource = MockRemoteDataSource();
    networkInfo = MockNetworkInfo();
    repository = NumberTriviaRepositoryImpl(
        remoteDataSource: remoteDataSource,
        localDataSource: localDataSource,
        networkInfo: networkInfo);
  });

  void runTestOnline(Function body) {
    group('If online', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body) {
    group('If offline', () {
      setUp(() {
        when(networkInfo.isConnected).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group('Get concrete number trivia', () {
    final int tNumber = 1;
    final NumberTriviaModel numberTriviaModel =
        NumberTriviaModel(text: 'test trivia', number: tNumber);
    final numberTrivia = numberTriviaModel;
    test('check if internet is available', () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      repository.getConcreteNumberTrivia(1);
      verify(networkInfo.isConnected);
    });
    runTestOnline(() {
      test('Should return from remote', () async {
        when(remoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => numberTriviaModel);

        final result = await repository.getConcreteNumberTrivia(tNumber);
        verify(remoteDataSource.getConcreteNumberTrivia(tNumber));
        expect(result, equals(Right(numberTrivia)));
      });
      test('Should Cache from remote', () async {
        when(remoteDataSource.getConcreteNumberTrivia(any))
            .thenAnswer((_) async => numberTriviaModel);
        await repository.getConcreteNumberTrivia(tNumber);
        verify(remoteDataSource.getConcreteNumberTrivia(tNumber));
        verify(localDataSource.cacheNumberTrivia(numberTriviaModel));
      });

      test('Should handle failure', () async {
        when(remoteDataSource.getConcreteNumberTrivia(any))
            .thenThrow(ServerException());

        final result = await repository.getConcreteNumberTrivia(tNumber);
        verify(remoteDataSource.getConcreteNumberTrivia(tNumber));
        verifyZeroInteractions(localDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test('Should return last locally number trivia if present', () async {
        when(localDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => numberTriviaModel);
        final result = await repository.getConcreteNumberTrivia(tNumber);
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getLastNumberTrivia());
        expect(result, equals(Right(numberTrivia)));
      });
      test('Should return cached failure if no data present', () async {
        when(localDataSource.getLastNumberTrivia())
            .thenThrow((CachedException()));
        final result = await repository.getConcreteNumberTrivia(tNumber);
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getLastNumberTrivia());
        expect(result, Left(CachedFailure()));
      });
    });
  });

  group('Get random number trivia', () {
    final int tNumber = 1;
    final NumberTriviaModel numberTriviaModel =
        NumberTriviaModel(text: 'test trivia', number: tNumber);
    final numberTrivia = numberTriviaModel;
    test('check if internet is available', () async {
      when(networkInfo.isConnected).thenAnswer((_) async => true);
      repository.getRandomTrivia();
      verify(networkInfo.isConnected);
    });
    runTestOnline(() {

      test('Should return from remote', () async {
        when(remoteDataSource.getRandomTrivia())
            .thenAnswer((_) async => numberTriviaModel);

        final result = await repository.getRandomTrivia();
        verify(remoteDataSource.getRandomTrivia());
        expect(result, equals(Right(numberTrivia)));
      });

      test('Should Cache from remote', () async {
        when(remoteDataSource.getRandomTrivia())
            .thenAnswer((_) async => numberTriviaModel);
        await repository.getRandomTrivia();
        verify(remoteDataSource.getRandomTrivia());
        verify(localDataSource.cacheNumberTrivia(numberTriviaModel));
      });

      test('Should handle failure', () async {
        when(remoteDataSource.getRandomTrivia())
            .thenThrow(ServerException());

        final result = await repository.getRandomTrivia();
        verify(remoteDataSource.getRandomTrivia());
        verifyZeroInteractions(localDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline(() {
      test('Should return last locally number trivia if present', () async {
        when(localDataSource.getLastNumberTrivia())
            .thenAnswer((_) async => numberTriviaModel);
        final result = await repository.getRandomTrivia();
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getLastNumberTrivia());
        expect(result, equals(Right(numberTrivia)));
      });
      test('Should return cached failure if no data present', () async {
        when(localDataSource.getLastNumberTrivia())
            .thenThrow((CachedException()));
        final result = await repository.getRandomTrivia();
        verifyZeroInteractions(remoteDataSource);
        verify(localDataSource.getLastNumberTrivia());
        expect(result, Left(CachedFailure()));
      });
    });
  });
}
