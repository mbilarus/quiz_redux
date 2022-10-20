import 'package:quiz_redux/src/isolate.dart';
import 'package:flutter/material.dart';
import 'package:quiz_redux/src/redux.dart';
import 'app.dart';

void main() async {
  await setupQuizIsolate();
  quizListStore = initQuizListStore();
  runApp(const MyApp());
}

