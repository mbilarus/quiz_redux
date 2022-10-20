import 'package:quiz_redux/src//models.dart';

class QuizListReceiveAction {
  List<QuizItem> quizItems;
  QuizListReceiveAction(this.quizItems);
}

class QuizAnswerIsTrue {
  int questionIndex;
  QuizAnswerIsTrue(this.questionIndex);
}

class QuizListClear {}