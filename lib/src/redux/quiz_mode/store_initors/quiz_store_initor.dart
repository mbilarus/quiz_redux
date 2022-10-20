import 'package:redux/redux.dart';

import 'package:quiz_redux/src/redux/quiz_mode/reducers.dart';
import 'package:quiz_redux/src/models.dart';
import 'package:quiz_redux/src/enums.dart';

late Store<QuizMode> quizModeStore;

Store<QuizMode> initQuizModeStore () {
  return Store<QuizMode>(quizModeReducer,
      initialState: QuizMode(
        category: QuizCategory.fromString(QuizCategory.values.first.value),
        difficulty: QuizDifficulty.fromString(QuizDifficulty.values.first.value),
      ));
}