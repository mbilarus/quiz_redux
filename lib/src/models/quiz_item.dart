import 'package:equatable/equatable.dart';

class QuizItem extends Equatable {
  final String question;
  final Map<String, dynamic> answers;
  final Map<String, dynamic> correctAnswers;
  final bool isAnsweredTrue;

  const QuizItem(
      {required this.question,
      required this.answers,
      required this.correctAnswers,
      this.isAnsweredTrue = false});

  factory QuizItem.fromJson(Map<String, dynamic> json) {
    return QuizItem(
        question: json['question'],
        answers: json['answers'],
        correctAnswers: json['correct_answers'],
        isAnsweredTrue: json['is_answered_true'] ?? false);
  }

  QuizItem copyWith(
      {String? question,
      Map<String, dynamic>? answers,
      Map<String, dynamic>? correctAnswers,
      bool? isAnsweredTrue}) {
    return QuizItem(
      question: question ?? this.question,
      answers: answers ?? this.answers,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      isAnsweredTrue: isAnsweredTrue ?? this.isAnsweredTrue,
    );
  }

  Map<String, dynamic> get json => {
        'question': question,
        'answers': answers,
        'correct_answers': correctAnswers,
        'is_answered_true': isAnsweredTrue,
      };

  @override
  List<Object?> get props => [
        question,
        answers,
        correctAnswers,
      ];
}
