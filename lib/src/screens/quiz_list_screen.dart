import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:quiz_redux/src/redux.dart';
import 'package:quiz_redux/src/models.dart';

class QuizListScreen extends StatefulWidget {
  const QuizListScreen({Key? key}) : super(key: key);

  @override
  State<QuizListScreen> createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuizListScreen> {
  int questionIndex = 0;
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: quizListStore,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              'Викторина ${quizModeStore.state.category}, вопрос №${questionIndex + 1}.'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: StoreConnector<List<QuizItem>, bool>(
            converter: (store) => store.state.isNotEmpty,
            builder: (context, isNotEmpty) {
              if (isNotEmpty) {
                return SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      StoreConnector<List<QuizItem>, QuizItem>(
                        converter: (store) => store.state[questionIndex],
                        builder: (context, quizItem) {
                          return Column(
                            children: [
                              Text(quizItem.question),
                              ...(quizItem.answers.values.toList()
                                ..removeWhere((v) => v == null))
                                  .map(
                                    (answer) => Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: ElevatedButton(
                                    onPressed: () => setState(() {
                                      final currentAnswerIndex = quizItem
                                          .answers.values
                                          .toList()
                                          .indexOf(answer);
                                      final isTrue = quizItem
                                          .correctAnswers.values
                                          .toList()[
                                      currentAnswerIndex] ==
                                          "true";
                                      if (isTrue) {
                                        quizListStore.dispatch(
                                          QuizAnswerIsTrue(
                                            quizListStore.state
                                                .indexOf(quizItem),
                                          ),
                                        );
                                      }
                                      if (questionIndex <
                                          quizListStore.state.length - 1) {
                                        questionIndex++;
                                      }
                                    }),
                                    child: Text(
                                      answer,
                                    ),
                                  ),
                                ),
                              )
                                  .toList(),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else {
                return const LoadingIndicator(
                    indicatorType: Indicator.ballPulse);
              }
            },
          ),
        ),
      ),
    );
  }
}