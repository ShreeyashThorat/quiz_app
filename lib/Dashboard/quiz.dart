import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/Dashboard/score_page.dart';

class QuizQuestion {
  final String question;
  final List<String> options;
  final int answerIndex;
  final String explanation;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.answerIndex,
    required this.explanation,
  });
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late AnimationController controller;
  List<QuizQuestion> _quizQuestions = [];
  int _currentQuestionIndex = 0;
  int _userAnswerIndex = -1;
  int _remainingTime = 60;
  User? currentUser = FirebaseAuth.instance.currentUser;

  StreamSubscription? _timerSubscription;

  @override
  void initState() {
    super.initState();
    _loadQuizQuestions();
  }

  void _loadQuizQuestions() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('Quiz').get();
    final List<QuizQuestion> quizQuestions = [];
    // ignore: avoid_function_literals_in_foreach_calls
    querySnapshot.docs.forEach((doc) {
      final data = doc.data();
      final options = List<String>.from(data['Answer']);
      quizQuestions.add(
        QuizQuestion(
          question: data['Question'],
          options: options,
          answerIndex: data['Correct Answer'],
          explanation: data['Explanation'],
        ),
      );
    });
    setState(() {
      _quizQuestions = quizQuestions;
    });
  }

  void _startTimer() {
    _timerSubscription = Stream.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _remainingTime--;
      });
      if (_remainingTime <= 0) {
        _timerSubscription?.cancel();
        _nextQuestion();
      }
    }).takeWhile((_) => _remainingTime > 0).listen(null);
  }

  void _stopTimer() {
    _timerSubscription?.cancel();
    setState(() {
      _remainingTime = 60;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _quizQuestions.length - 1) {
      _stopTimer();
      setState(() {
        _currentQuestionIndex++;
        _userAnswerIndex = -1;
        _startTimer();
      });
    } else {
      _showScorePage();
    }
  }

  Future<void> _showScorePage() async {
    int score = 0;
    List<Map<String, dynamic>> scoreDetails = [];
    for (int i = 0; i < _quizQuestions.length; i++) {
      final question = _quizQuestions[i];
      final selectedAnswer =
          _userAnswerIndex == -1 ? null : question.options[_userAnswerIndex];
      final correctAnswer = question.options[question.answerIndex];
      scoreDetails.add({
        'question': question.question,
        'options': question.options,
        'selectedAnswer': selectedAnswer,
        'correctAnswer': correctAnswer,
        'explanation': question.explanation,
      });
      if (selectedAnswer == correctAnswer) {
        score++;
      }
    }
    if (currentUser != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .get();

      if (userSnapshot.exists) {
        int bestScore = userSnapshot.get('Best Score');
        String uid = FirebaseAuth.instance.currentUser!.uid.toString();
        if (bestScore < score) {
          FirebaseFirestore.instance.collection('Users').doc(uid).set(
              {'Last Score': score, 'Best Score': score},
              SetOptions(merge: true)).then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    ScorePage(score: score, scoreDetails: scoreDetails),
              ),
            );
          });
        } else {
          FirebaseFirestore.instance.collection('Users').doc(uid).set({
            'Last Score': score,
          }, SetOptions(merge: true)).then((value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    ScorePage(score: score, scoreDetails: scoreDetails),
              ),
            );
          });
        }
      } else {
        String uid = FirebaseAuth.instance.currentUser!.uid.toString();
        FirebaseFirestore.instance.collection('Users').doc(uid).set(
            {'Last Score': score, 'uid': uid, 'Best Score': score},
            SetOptions(merge: true)).then((value) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  ScorePage(score: score, scoreDetails: scoreDetails),
            ),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        backgroundColor: const Color(0xff2A40CE),
      ),
      body: _quizQuestions.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question ${_currentQuestionIndex + 1} of ${_quizQuestions.length}',
                    style: const TextStyle(
                        fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    _quizQuestions[_currentQuestionIndex].question,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  ...List.generate(
                      _quizQuestions[_currentQuestionIndex].options.length,
                      (index) {
                    final option =
                        _quizQuestions[_currentQuestionIndex].options[index];
                    return RadioListTile(
                      title: Text(option),
                      value: index,
                      groupValue: _userAnswerIndex,
                      onChanged: (value) {
                        setState(() {
                          _userAnswerIndex = value!;
                        });
                      },
                    );
                  }),
                  const SizedBox(height: 16.0),
                  Text(
                    'Time remaining: $_remainingTime seconds',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(const Color(0xff2A40CE)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ))),
            onPressed: () {
              _nextQuestion();
            },
            child: Text(_currentQuestionIndex < _quizQuestions.length - 1
                ? 'Next'
                : 'Finish'),
          ),
        ),
      ),
    );
  }
}
