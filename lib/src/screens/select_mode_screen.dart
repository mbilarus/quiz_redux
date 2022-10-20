import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:quiz_redux/src/redux.dart';
import 'package:quiz_redux/src/models.dart';
import 'package:quiz_redux/src/enums.dart';
import 'package:quiz_redux/src/screens/quiz_list_screen.dart';

class SelectModeScreen extends StatelessWidget {
  const SelectModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryItems = receiveCategoryItems();
    final difficultyItems = receiveDifficultyItems();
    quizModeStore = initQuizModeStore();
    return StoreProvider<QuizMode>(
      store: quizModeStore,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Выбор режима'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: 10,
            children: [
              Row(
                children: const [
                  Text('Выберите тему викторины:'),
                ],
              ),
              StoreConnector<QuizMode, String>(
                converter: (store) => store.state.category.toString(),
                builder: (_, quizCategory) =>
                    StoreConnector<QuizMode, void Function(QuizCategory)>(
                      converter: (store) => (category) => store.dispatch(
                          QuizModeChangeAction(QuizMode(category: category))),
                      builder: (context, callback) => DropdownButton<String>(
                        isExpanded: true,
                        value: quizCategory,
                        items: categoryItems,
                        onChanged: (category) {
                          quizListStore.dispatch(QuizListClear());
                          callback(QuizCategory.fromString(category));
                        },
                      ),
                    ),
              ),
              Row(
                children: const [
                  Text('Выберите сложность викторины:'),
                ],
              ),
              StoreConnector<QuizMode, String>(
                converter: (store) => store.state.difficulty.toString(),
                builder: (_, quizDifficulty) =>
                    StoreConnector<QuizMode, void Function(QuizDifficulty)>(
                      converter: (store) => (difficulty) => store.dispatch(
                          QuizModeChangeAction(QuizMode(difficulty: difficulty))),
                      builder: (context, callback) => DropdownButton<String>(
                        isExpanded: true,
                        value: quizDifficulty,
                        items: difficultyItems,
                        onChanged: (difficulty) {
                          quizListStore.dispatch(QuizListClear());
                          callback(QuizDifficulty.fromString(difficulty));
                        },
                      ),
                    ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return const QuizListScreen();
                        },
                      ),
                    );
                  },
                  child: const Text('Начать'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> receiveCategoryItems() {
    return QuizCategory.values
        .map(
          (category) => DropdownMenuItem<String>(
        value: '$category',
        child: Text('$category'),
      ),
    )
        .toList();
  }

  List<DropdownMenuItem<String>> receiveDifficultyItems() {
    return QuizDifficulty.values
        .map(
          (difficulty) => DropdownMenuItem<String>(
        value: '$difficulty',
        child: Text('$difficulty'),
      ),
    )
        .toList();
  }
}