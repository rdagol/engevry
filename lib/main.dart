import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/question.dart';

void main() {
  runApp(const EngEvryApp());
}

class EngEvryApp extends StatelessWidget {
  const EngEvryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Eng Evry',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eng Evry'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ToeicScreen()),
                );
              },
              child: const Text('TOEIC'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IeltsScreen()),
                );
              },
              child: const Text('IELTS'),
            ),
          ],
        ),
      ),
    );
  }
}

class ToeicScreen extends StatelessWidget {
  const ToeicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TOEIC Practice'),
      ),
      body: const QuizScreen(
        assetPath: 'assets/questions/toeic_questions.json',
      ),
    );
  }
}

class IeltsScreen extends StatelessWidget {
  const IeltsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IELTS Practice'),
      ),
      body: const QuizScreen(
        assetPath: 'assets/questions/ielts_questions.json',
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    required this.assetPath,
    super.key,
  });

  final String assetPath;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final Future<List<Question>> questionsFuture;
  int currentQuestionIndex = 0;
  int? selectedAnswerIndex;
  int score = 0;
  bool answered = false;

  @override
  void initState() {
    super.initState();
    questionsFuture = loadQuestions();
  }

  Future<List<Question>> loadQuestions() async {
    final jsonString = await rootBundle.loadString(widget.assetPath);
    final jsonList = jsonDecode(jsonString) as List<dynamic>;

    return jsonList
        .map((item) => Question.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Question>>(
      future: questionsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Could not load questions.'));
        }

        final questions = snapshot.data ?? [];
        if (questions.isEmpty) {
          return const Center(child: Text('No questions yet.'));
        }

        if (currentQuestionIndex >= questions.length) {
          return Center(
            child: Text(
              'Finished! Score: $score/${questions.length}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        }

        final question = questions[currentQuestionIndex];
        final selectedIndex = selectedAnswerIndex;

        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                question.text,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              for (var i = 0; i < question.choices.length; i++) ...[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedAnswerIndex = i;
                      if (!answered) {
                        answered = true;
                        if (i == question.correctAnswerIndex) {
                          score++;
                        }
                      }
                    });
                  },
                  child: Text(question.choices[i]),
                ),
                const SizedBox(height: 12),
              ],
              const SizedBox(height: 12),
              if (selectedIndex != null)
                Column(
                  children: [
                    Text(
                      selectedIndex == question.correctAnswerIndex
                          ? 'Correct!'
                          : 'Try again.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: answered
                          ? () {
                              setState(() {
                                currentQuestionIndex++;
                                selectedAnswerIndex = null;
                                answered = false;
                              });
                            }
                          : null,
                      child: Text(
                        currentQuestionIndex == questions.length - 1
                            ? 'Finish'
                            : 'Next',
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
