import 'package:mockito/mockito.dart';
import 'package:number_trivia/core/usecase/usecase.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetRandomNumberTrivia useCase;
  MockNumberTriviaRepository mockNumberTriviaRepository;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    useCase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });
  final NumberTrivia tNumberTrivia =
      NumberTrivia(number: 1, text: 'my trivia 1');
  test('should get trivia for number from repository', () async {
    // arrange
    when(mockNumberTriviaRepository.getRandomTrivia())
        .thenAnswer((_) async => Right(tNumberTrivia));
    //act
    final result = await useCase(NoParams());
    expect(result, Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getRandomTrivia());
    verifyNoMoreInteractions(mockNumberTriviaRepository);
    // assert
  });
}
