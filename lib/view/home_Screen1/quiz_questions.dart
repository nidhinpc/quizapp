import 'package:flutter/material.dart';
import 'package:quizapp/dummydb.dart';
import 'package:quizapp/utils/colorconstants.dart';
import 'package:quizapp/view/result_screen/result_screen.dart';

class QuizQuestions extends StatefulWidget {
  const QuizQuestions({super.key});

  @override
  State<QuizQuestions> createState() => _QuizQuestionsState();
}

class _QuizQuestionsState extends State<QuizQuestions> {
  bool _isAnswered = false;
  int questIndex = 0;
  int currentquest = 1;
  int currentIndex = 0;
  int lastquest = Dummydb.questionList.length;
  int? selectedoption;
  int rightAnswerCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Text("$currentquest/$lastquest")],
      ),
      backgroundColor: ColorConstants.BackgroundColor,
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: ColorConstants.questionsBgColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.white)),
                  child: Center(
                      child:
                          Text(Dummydb.questionList[questIndex]["question"])),
                ),
              ),
              Column(
                  children: List.generate(
                      Dummydb.questionList[currentIndex]["options"].length,
                      (optionIndex) {
                var currentQuestion = Dummydb.questionList[currentIndex];
                return Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InkWell(
                    onTap: () {
                      if (!_isAnswered) {
                        selectedoption = optionIndex;
                        if (selectedoption ==
                            Dummydb.questionList[currentIndex]["answerIndex"]) {
                          rightAnswerCount = rightAnswerCount + 1;
                        }
                        setState(() {});
                        print(selectedoption);
                        _isAnswered = true;
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: getColor(optionIndex), width: 2)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            currentQuestion["options"][optionIndex],
                            style: TextStyle(
                                color: ColorConstants.textColor, fontSize: 16),
                          ),
                          Icon(
                            Icons.circle_outlined,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })),
              SizedBox(
                height: 20,
              ),
              if (selectedoption != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: () {
                      selectedoption = null;

                      if (questIndex < lastquest - 1) {
                        currentIndex++;
                        currentquest++;
                        questIndex++;

                        _isAnswered = false;
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(
                                rightAnswerCount: rightAnswerCount,
                              ),
                            ));
                      }

                      setState(() {});
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 5, 131, 234),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white)),
                      child: Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                              color: ColorConstants.textColor, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                )
            ],
          )),
    );
  }

  Color getColor(int currentoptionIndex) {
    if (selectedoption != null &&
        currentoptionIndex ==
            Dummydb.questionList[currentIndex]["answerIndex"]) {
      return ColorConstants.rightAnswerColor;
    }
    if (selectedoption == currentoptionIndex) {
      if (selectedoption == Dummydb.questionList[currentIndex]["answerIndex"]) {
        return ColorConstants.rightAnswerColor;
      } else {
        return ColorConstants.wrongAnswerColor;
      }
    } else {
      return ColorConstants.textColor;
    }
  }
}
