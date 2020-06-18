import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizflutterapp/services/database.dart';
import 'file:///C:/Users/M4TECH/AndroidStudioProjects/quiz_flutter_app/lib/widget/widget.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  AddQuestion(this.quizId);

  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {

  final _keyform = GlobalKey<FormState>();

  String question , option1 , option2 , option3 ,option4 ;
  bool _isloading = false;

  DataBaseServices dataBaseServices = new DataBaseServices();

  uploadQuestionData(){

    if(_keyform.currentState.validate())
      {
        setState(() {
          _isloading = true;
        });
        Map<String , String> questionMap = {
          "question" : question,
          "option1" : option1 ,
          "option2" : option2 ,
          "option3" : option3,
          "option4" : option4
        };
        dataBaseServices.addQuestionData(questionMap, widget.quizId).then((value) {
          setState(() {
            _isloading = false;
          });
        });
      }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Form(
        key: _keyform,
        child:  _isloading ? Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ):Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Question" : null,
                decoration: InputDecoration(
                    hintText: "Question"
                ),
                onChanged: (val){
                  question = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option1" : null,
                decoration: InputDecoration(
                    hintText: "Option1 (correct Answer)"
                ),
                onChanged: (val){
                  option1 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option2" : null,
                decoration: InputDecoration(
                    hintText: "Option2"
                ),
                onChanged: (val){
                  option2 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option3" : null,
                decoration: InputDecoration(
                    hintText: "Option3"
                ),
                onChanged: (val){
                  option3 = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Option4" : null,
                decoration: InputDecoration(
                    hintText: "Option4"
                ),
                onChanged: (val){
                  option4 = val;
                },
              ),
              SizedBox(height: 6,),
              Spacer(),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      width: MediaQuery.of(context).size.width/2-36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Text("Submit", style: TextStyle(
                          color: Colors.white , fontSize: 16),
                    ),),
                  ),
                  SizedBox(width: 24,),
                  GestureDetector(
                    onTap: (){
                      uploadQuestionData();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      width: MediaQuery.of(context).size.width/2-36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30)
                      ),
                      child: Text("Add Question", style: TextStyle(
                          color: Colors.white , fontSize: 16),
                      ),),
                  )
                ],
              ),
              SizedBox(height: 60,)
            ],
          ),
        ),
      ),
    );
  }
}
