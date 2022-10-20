class QuizDifficulty {
  final String difficulty;

  static const easy = QuizDifficulty._('Easy');
  static const medium = QuizDifficulty._('Medium');
  static const hard = QuizDifficulty._('Hard');

  factory QuizDifficulty.fromString(String? value) {
    return values.firstWhere(
          (quizDifficulty) => value == quizDifficulty.value,
      orElse: () => throw Exception(
        'This value is not suitable for a QuizDifficulty',
      ),
    );
  }

  String get value => difficulty;

  @override
  String toString() => difficulty;

  static const List<QuizDifficulty> values = [
    easy,
    medium,
    hard,
  ];

  const QuizDifficulty._(this.difficulty);
}