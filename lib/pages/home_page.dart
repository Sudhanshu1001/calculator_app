import 'package:calculator_app/components/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';
  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    '*',
    '6',
    '5',
    '4',
    '-',
    '2',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(height: 40),

                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(20),
                    child: Text(userQuestion, style: TextStyle(fontSize: 20)),
                  ),

                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(20),
                    child: Text(userAnswer, style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  //Clear button
                  if (index == 0) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = '';
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.green,
                      textColor: Colors.white,
                    );
                  } else if (index == 1) {
                    //delete button

                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          if (userQuestion.isNotEmpty) {
                            userQuestion = userQuestion.substring(
                              0,
                              userQuestion.length - 1,
                            );
                          }
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.red,
                      textColor: Colors.white,
                    );
                  }
                  // Equal button
                  else if (index == buttons.length - 1) {
                    //delete button

                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.purpleAccent,
                      textColor: Colors.white,
                    );
                  } else {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                      buttonText: buttons[index],
                      color:
                          isOperator(buttons[index])
                              ? Colors.deepPurple
                              : Colors.deepPurple[50],
                      textColor:
                          isOperator(buttons[index])
                              ? Colors.white
                              : Colors.deepPurple,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == '-' || x == '+' || x == '=' || x == '*') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    ExpressionParser p = GrammarParser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    var evaluator = RealEvaluator();
    num eval = evaluator.evaluate(exp);
    userAnswer = eval.toString();
  }
}
