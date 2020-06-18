import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizflutterapp/services/database.dart';
import 'package:quizflutterapp/views/add_question.dart';
import 'file:///C:/Users/M4TECH/AndroidStudioProjects/quiz_flutter_app/lib/widget/widget.dart';
import 'package:random_string/random_string.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {

  final _formKey = GlobalKey<FormState>();
  String quizImageUrl , quizTitle , quizDescription , quizId;
  bool _isLoading = false;

  DataBaseServices dataBaseServices = new DataBaseServices();

  CreateQuizOnline()
  {
    if(_formKey.currentState.validate())
      {
        setState(() {
          _isLoading = true;
        });
        quizId = randomAlphaNumeric(16);
        Map<String , String> quizMap = {
          "quizId" : quizId ,
          "quizImgUrl" : quizImageUrl,
          "quizTitle" : quizTitle,
          "quizDesc" : quizDescription
        };
        dataBaseServices.addQuizData(quizMap, quizId).then((value) {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => AddQuestion( quizId,)
          ));
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
      body: _isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ): Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Image Url" : null,
                decoration: InputDecoration(
                  hintText: "Quiz Image Url"
                ),
                onChanged: (val){
                  quizImageUrl = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Image Title" : null,
                decoration: InputDecoration(
                    hintText: "Quiz Image Title"
                ),
                onChanged: (val){
                  quizTitle = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val) => val.isEmpty ? "Enter Image Desc" : null,
                decoration: InputDecoration(
                    hintText: "Quiz Image Desc"
                ),
                onChanged: (val){
                  quizDescription = val;
                },
              ),
              SizedBox(height: 6,),
              Spacer(),
            GestureDetector(
              onTap: (){
                CreateQuizOnline();
              },
                child: blueButton(context, "Create Quiz")),
              SizedBox(height: 60,)
            ],
          ),
        ),
      ),
    );
  }
}
