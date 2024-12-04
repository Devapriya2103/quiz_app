import 'package:flutter/material.dart';
import 'package:quiz_app/dummy_db.dart';
import 'package:quiz_app/view/category_screen/category_screen.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key, required this.rightAnsCount});

  final int rightAnsCount;

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
 int starCount = 0;
 @override
  void initState() {
   calculatePercentage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              3, 
              (index) => Padding(
                padding: EdgeInsets.only(right: 15,left: 15,bottom: index == 1 ? 30 : 0),
                child: Icon(Icons.star,
                color: starCount > index ? Colors.yellowAccent.shade400 :Colors.grey,
                size: index == 1 ? 70 : 40,
                ),
                ),
              ),
          ),
          SizedBox(height: 30),
          Text("Congratulations",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.yellowAccent.shade400,
          ),
          ),
          SizedBox(height: 25),
          Text("Your Score",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          ),
          SizedBox(height: 5),
          Text("${widget.rightAnsCount}/${DummyDb.sportsQuestions.length}",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.yellowAccent.shade400,
          ),
          ),
          //resstart button
          SizedBox(height: 50),
                 InkWell(
                   onTap: () {
                       Navigator.pushReplacement(context, 
                       MaterialPageRoute(builder: (context) => CategoryScreen(),),
                       );                     
                   },
                   child: Container(
                     width: 250,
                     padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(8),
                       color: Colors.blue.shade400,
                     ),
                     child: Center(
                       child: Text("Restart",
                       style: TextStyle(
                         color: Colors.white,
                       ),
                       ),
                     ),
                   ),
                 ),
        ],
      ),
    );
  }

  calculatePercentage() {
    num percentage = (widget.rightAnsCount/DummyDb.sportsQuestions.length)*100;
    if (percentage >= 90) {
      starCount = 3;
    } else if (percentage >= 50) {
    starCount = 2;
    } else if (percentage >= 30) {
      starCount = 1;
    }
    setState(() {});
  }
}