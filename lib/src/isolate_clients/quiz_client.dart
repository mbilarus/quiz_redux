import 'package:dio/dio.dart';

import '../enums.dart';

class IsolateQuizClient {
  Future<List> find(
      {int? limit,
        QuizCategory? quizCategory,
        QuizDifficulty? quizDifficulty,
        CancelToken? token}) async {
    final List quizItems = (await Dio().get(
      'https://quizapi.io/api/v1/questions',
      cancelToken: token,
      queryParameters: {
        'limit': '$limit',
        'category': quizCategory?.value,
        'difficulty': quizDifficulty?.value
      },
      options: Options(
        headers: {
          'X-Api-Key': 'ELjnT6n7593qhuWLLaenyIcNQmJ5WWYF6xz7CHb8',
        },
      ),
    ))
        .data
        .toList();
    return quizItems;
  }
}