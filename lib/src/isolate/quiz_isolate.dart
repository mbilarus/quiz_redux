import 'dart:async';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:quiz_redux/src/isolate_clients.dart';
import 'package:quiz_redux/src/enums.dart';
import 'package:quiz_redux/src/redux.dart';
import 'package:quiz_redux/src/models.dart';

import '../redux.dart';


void quizIsolate(SendPort isolateToMainStream) {
  ReceivePort mainToIsolateStream = ReceivePort();
  var isolateQuizClient = IsolateQuizClient();

  isolateToMainStream.send(mainToIsolateStream.sendPort);
  CancelToken? token;
  dynamic quizData;

  mainToIsolateStream.listen((data) async {
    if (data is Map) {
      if (token != null) {
        token?.cancel();
      }
      token = CancelToken();
      quizData = await isolateQuizClient.find(
          limit: 10,
          quizCategory: QuizCategory.fromString(data['category']),
          quizDifficulty: QuizDifficulty.fromString(data['difficulty']));
      isolateToMainStream.send(quizData);
    }
  });
}

Future<SendPort> initQuizIsolate() async {
  Completer sendPortCompleter = Completer<SendPort>();
  ReceivePort mainPort = ReceivePort();

  mainPort.listen((data) {
    if (data is SendPort) {
      sendPortCompleter.complete(data);
    } else if (data is List) {
      quizListStore.dispatch(
        QuizListReceiveAction(
          data.map<QuizItem>((json) => QuizItem.fromJson(json)).toList(),
        ),
      );
    }
  });

  await Isolate.spawn(quizIsolate, mainPort.sendPort);
  return sendPortCompleter.future as FutureOr<SendPort>;
}

late SendPort quizIsolateSendPort;

Future<void> setupQuizIsolate () async {
  quizIsolateSendPort = await initQuizIsolate();
  quizIsolateSendPort.send(
    {
      'category': QuizCategory.linux.toString(),
      'difficulty': QuizDifficulty.easy.toString(),
    },
  );
}
