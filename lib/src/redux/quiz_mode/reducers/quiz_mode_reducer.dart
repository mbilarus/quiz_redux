import 'package:quiz_redux/src/models.dart';
import 'package:quiz_redux/src/redux/quiz_mode/actions.dart';
import 'package:quiz_redux/src/isolate.dart';

QuizMode quizModeReducer(QuizMode state, dynamic action) {
  if (action.runtimeType == QuizModeChangeAction) {
    final QuizMode mode = QuizMode(
      category: action.quizMode.category ?? state.category,
      difficulty: action.quizMode.difficulty ?? state.difficulty,
    );
    quizIsolateSendPort.send(
      {
        'category': mode.category.toString(),
        'difficulty': mode.difficulty.toString()
      },
    );
    return mode;
  }
  return state;
}