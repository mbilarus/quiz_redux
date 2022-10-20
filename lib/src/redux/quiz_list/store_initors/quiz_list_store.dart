import 'package:quiz_redux/src/models.dart';
import 'package:quiz_redux/src/redux/quiz_list/reducers.dart';
import 'package:redux/redux.dart';

late Store<List<QuizItem>> quizListStore;
Store<List<QuizItem>> initQuizListStore() {
  return Store<List<QuizItem>>(quizListReducer, initialState: []);
}