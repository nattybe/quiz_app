import 'quiz_brain.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();
void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey[800],
          title: Text('Quizzer'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Quizzer(),
          ),
        ),
      ),
    ),
  );
}

class Quizzer extends StatefulWidget {
  const Quizzer({Key? key}) : super(key: key);

  @override
  State<Quizzer> createState() => _QuizzerState();
}

List<Icon> sK = [];
int score = 0;

class _QuizzerState extends State<Quizzer> {
  @override
  Widget build(BuildContext context) {
        void reset() {
      quizBrain.reset();
      sK = [];
      score=0;
    }
    bool answerpro(bool ans) {
      bool res = true;
      if (quizBrain.isfinished()) {
        setState(() {
          Alert(
            context: context,
            title: 'Congragulations',
            desc: 'You have scored $score \n out of 13',
            buttons: [
              DialogButton(
                child: Text(
                  "Restart",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onPressed: () {setState(() {
                  reset();
                });},
                width: 120,
              )
            ],
          ).show();
        });
      } else {
        if (ans == quizBrain.getAnswer()) {
          res = true;
          score++;
          quizBrain.nextQue();
          sK.add(Icon(
            Icons.check,
            color: Color.fromARGB(255, 76, 175, 79),
          ));
        } else {
          res = false;
          quizBrain.nextQue();
          sK.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
      }
      return res;
    }



    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Center(
            child: Text(
              quizBrain.getQuestion(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: FlatButton(
              color: Colors.green,
              child: Text(
                'true',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                answerpro(true);
                setState(() {});
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'false',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              onPressed: () {
                answerpro(false);
                setState(() {});
              },
            ),
          ),
        ),
        Row(
          children: sK,
        )
      ],
    );
  }
}
