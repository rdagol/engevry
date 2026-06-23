class Question {
  const Question({
    required this.text,
    required this.choices,
    required this.correctAnswerIndex,
  });

  final String text;
  final List<String> choices;
  final int correctAnswerIndex;

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'] as String,
      choices: List<String>.from(json['choices'] as List),
      correctAnswerIndex: json['correctAnswerIndex'] as int,
    );
  }
}
