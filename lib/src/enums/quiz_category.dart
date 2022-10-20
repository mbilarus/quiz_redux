class QuizCategory {
  final String category;
  static const linux = QuizCategory._('Linux');
  static const devOps = QuizCategory._('DevOps');
  static const docker = QuizCategory._('Docker');

  factory QuizCategory.fromString(String? value) {
    return values.firstWhere(
          (quizCategory) => value == quizCategory.value,
      orElse: () => throw Exception(
        'This value is not suitable for a QuizThematic',
      ),
    );
  }

  String get value => category;

  @override
  String toString() => category;

  static const values = [
    linux,
    devOps,
    docker,
  ];
  const QuizCategory._(this.category);
}
