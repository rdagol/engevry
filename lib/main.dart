import 'package:flutter/material.dart';

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
      body: const Center(
        child: Text('TOEIC Screen'),
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
      body: const Center(
        child: Text('IELTS Screen'),
      ),
    );
  }
}
