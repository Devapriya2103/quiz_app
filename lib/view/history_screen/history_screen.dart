import 'dart:developer';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/dummy_db.dart';
import 'package:quiz_app/view/results_screen/results_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {

  int currentQuestionIndex = 0;
  int? selectedAnsIndex; 
  int rightAnsCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            CircularCountDownTimer(
              duration: 10,
              initialDuration: 0,
              controller: CountDownController(),
              width: MediaQuery.of(context).size.width / 10,
              height: MediaQuery.of(context).size.height / 10,
              ringColor: Colors.grey[300]!,
              ringGradient: null,
              fillColor: Colors.purpleAccent[100]!,
              fillGradient: null,
              backgroundColor: Colors.purple[500],
              backgroundGradient: null,
              strokeWidth: 10.0,
              strokeCap: StrokeCap.round,
              textStyle: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              textFormat: CountdownTextFormat.S,
              isReverse: false,
              isReverseAnimation: false,
              isTimerTextShown: true,
              autoStart: true,
              onStart: () {
                debugPrint('Countdown Started');
              },
              onComplete: () {
                currentQuestionIndex++;
                setState(() {});
                debugPrint('Countdown Ended');
              },
              onChange: (String timeStamp) {
                debugPrint('Countdown Changed $timeStamp');
              },
              timeFormatterFunction: (defaultFormatterFunction, duration) {
                if (duration.inSeconds == 0) {
                  return "Start";
                } else {
                  return Function.apply(defaultFormatterFunction, [duration]);
                }
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Text(DummyDb.chemistryQuestions[currentQuestionIndex]["question"],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            ),
                          ),
                        ],
                      ),
                    ),
              ),
            ),
                SizedBox(height: 10),
                Column(
                  children: 
                    List.generate(
                      4, (optionIndex) => 
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: InkWell(
                          onTap: () {
                            if (selectedAnsIndex == null) {
                              selectedAnsIndex = optionIndex;
                              if (selectedAnsIndex ==
                              DummyDb.historyQuestions[currentQuestionIndex]["answerIndex"]
                              ) {
                                rightAnsCount++;
                                log(" right ans count = $rightAnsCount");
                              }
                              setState(() {});
                            }                          
                          },
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                              color: getColor(optionIndex),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Text(DummyDb.historyQuestions[currentQuestionIndex]["options"][optionIndex],
                                  style: TextStyle(color: Colors.white),),
                                  Spacer(),
                                  Icon(Icons.circle_outlined,color: Colors.white,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ),
                if(selectedAnsIndex != null) 
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      if (currentQuestionIndex < DummyDb.historyQuestions.length - 1) {
                      currentQuestionIndex++;
                      setState(() {});
                      selectedAnsIndex = null;
                      } else {
                        Navigator.pushReplacement(context, 
                        MaterialPageRoute(builder: (context) => ResultsScreen(rightAnsCount: rightAnsCount,),),
                        );
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue.shade400,
                      ),
                      child: Center(
                        child: Text("Start",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        ),
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }


  Color getColor (int clickedIndex) { 
    if (selectedAnsIndex != null) {
      if (DummyDb.historyQuestions[currentQuestionIndex]["answerIndex"] == clickedIndex) {
        return Colors.green;
      }
    }
    if (selectedAnsIndex == clickedIndex) {
      if (selectedAnsIndex == DummyDb.historyQuestions[currentQuestionIndex]["answerIndex"]) {  
        return Colors.green;  
      } else {
      return Colors.red;  
      } 
    } else {
      return Colors.grey.shade800;
    } 
  }
}