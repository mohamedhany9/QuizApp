import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/M4TECH/AndroidStudioProjects/quiz_flutter_app/lib/widget/widget.dart';
import 'package:quizflutterapp/model/question_model.dart';
import 'package:quizflutterapp/services/database.dart';
import 'package:quizflutterapp/views/result.dart';
import 'package:quizflutterapp/widget/quiz_play_widgets.dart';

class PlayQuiz extends StatefulWidget {
  final String quizId;

  PlayQuiz(this.quizId);

  @override
  _PlayQuizState createState() => _PlayQuizState();
}

int total = 0;
int _correct = 0;
int _incorrect = 0;
int _notAttampted = 0;

class _PlayQuizState extends State<PlayQuiz> {
  DataBaseServices dataBaseServices = new DataBaseServices();
  QuerySnapshot questionSnapshot;

  QuestionModel getQuestionModelFromDataSnapshot(
      DocumentSnapshot questionSnapshot) {
    QuestionModel questionModel = new QuestionModel();
    questionModel.question = questionSnapshot.data["question"];

    List<String> options = [
      questionSnapshot.data["option1"],
      questionSnapshot.data["option2"],
      questionSnapshot.data["option3"],
      questionSnapshot.data["option4"],
    ];
    options.shuffle();

    questionModel.option1 = options[0];
    questionModel.option2 = options[1];
    questionModel.option3 = options[2];
    questionModel.option4 = options[3];
    questionModel.correctOption = questionSnapshot.data["option1"];
    questionModel.answered = false;

    return questionModel;
  }

  @override
  void initState() {
    print("${widget.quizId}");
    dataBaseServices.getQuizuzData(widget.quizId).then((value) {
      questionSnapshot = value;
      _notAttampted = 0;
      _correct = 0;
      _incorrect = 0;
      total = questionSnapshot.documents.length;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        iconTheme: IconThemeData(color: Colors.black54),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              questionSnapshot == null
                  ? Container()
                  : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: questionSnapshot.documents.length,
                      itemBuilder: (context, index) {
                        return QuizPlayTile(
                          questionModel: getQuestionModelFromDataSnapshot(
                              questionSnapshot.documents[index]),
                          index: index,
                        );
                      },
                    )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: ()
        {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => Result(
             correct: _correct,
             incorrect: _incorrect,
             total: total,
            )
          ));
        },
      ),
    );
  }
}

class QuizPlayTile extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;

  QuizPlayTile({this.questionModel, this.index});

  @override
  _QuizPlayTileState createState() => _QuizPlayTileState();
}

class _QuizPlayTileState extends State<QuizPlayTile> {
  String optionSelected = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Q${widget.index+1} : ${widget.questionModel.question}",style: TextStyle(
            color: Colors.black,
            fontSize: 16
          ),),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                if (widget.questionModel.option1 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttampted = _notAttampted - 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option1;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttampted = _notAttampted - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option1,
              option: "A",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                if (widget.questionModel.option2 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttampted = _notAttampted - 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option2;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttampted = _notAttampted - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option2,
              option: "B",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                if (widget.questionModel.option3 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttampted = _notAttampted - 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option3;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttampted = _notAttampted - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option3,
              option: "C",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          GestureDetector(
            onTap: () {
              if (!widget.questionModel.answered) {
                if (widget.questionModel.option4 ==
                    widget.questionModel.correctOption) {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _correct = _correct + 1;
                  _notAttampted = _notAttampted - 1;
                  setState(() {});
                } else {
                  optionSelected = widget.questionModel.option4;
                  widget.questionModel.answered = true;
                  _incorrect = _incorrect + 1;
                  _notAttampted = _notAttampted - 1;
                  setState(() {});
                }
              }
            },
            child: OptionTile(
              correctAnswer: widget.questionModel.correctOption,
              description: widget.questionModel.option4,
              option: "D",
              optionSelected: optionSelected,
            ),
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}
