import 'package:flutter/material.dart';
import 'package:quizapp/utils/colorconstants.dart';
import 'package:quizapp/view/home_Screen1/quiz_questions.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: ColorConstants.BackgroundColor,
      ),
      home: QuizQuestions(),
    );
  }
}
