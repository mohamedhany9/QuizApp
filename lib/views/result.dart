import 'package:flutter/material.dart';
import 'package:quizflutterapp/widget/widget.dart';

class Result extends StatefulWidget {
  final correct , incorrect , total;
  Result({this.correct , this.incorrect , this.total});

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("${widget.correct}/${widget.total}" , style: TextStyle(
                color: Colors.blue , fontSize: 20 , fontWeight: FontWeight.bold
              ),),
              SizedBox(height: 8,),
              Text("You Answered ${widget.correct} answered correctly"
                  " and ${widget.incorrect} answered incorrectlt"),
              SizedBox(height: 50,),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                  child: blueButton(context, "Go Home"))
            ],
          ),
        ),
      ),
    );
  }
}
