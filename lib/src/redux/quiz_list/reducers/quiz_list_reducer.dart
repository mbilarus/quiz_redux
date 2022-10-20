import 'package:quiz_redux/src/redux/quiz_list/actions.dart';
import 'package:quiz_redux/src/models.dart';

List<QuizItem> quizListReducer(List<QuizItem> state, dynamic action) {
  if (action is QuizListReceiveAction) {
    return action.quizItems;
  }
  if (action is QuizListClear) {
    return [];
  }
  if (action is QuizAnswerIsTrue) {
    state[action.questionIndex] =
        state[action.questionIndex].copyWith(isAnsweredTrue: true);
    return state;
  }
  return state;
}