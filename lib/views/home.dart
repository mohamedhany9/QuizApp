import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizflutterapp/services/database.dart';
import 'package:quizflutterapp/views/create_quiz.dart';
import 'package:quizflutterapp/views/play_quiz.dart';
import 'file:///C:/Users/M4TECH/AndroidStudioProjects/quiz_flutter_app/lib/widget/widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Stream quizStream ;
  DataBaseServices dataBaseServices = new DataBaseServices();

  Widget quizList(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context , snapshot)
        {
          return snapshot.data == null ? Container()
              : ListView.builder(
            itemCount: snapshot.data.documents.length,
              itemBuilder: (context , index)
              {
                return QuizTile(
                  imgUrl: snapshot.data.documents[index].data["quizImgUrl"],
                  title: snapshot.data.documents[index].data["quizTitle"],
                  desc: snapshot.data.documents[index].data["quizDesc"],
                  quizId: snapshot.data.documents[index].data["quizId"],
                );
              }
          );
        },
      ),
    );
  }

  @override
  void initState() {
    dataBaseServices.getQuizData().then((val){
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: quizList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => CreateQuiz()
          ));
        },
      ),
    );
  }
}

class QuizTile extends StatelessWidget {

  final String imgUrl;
  final String title;
  final String desc;
  final String quizId;

  QuizTile({@required this.imgUrl ,@required this.title ,@required this.desc , @required this.quizId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        Navigator.push(context, MaterialPageRoute(
          builder: (context) => PlayQuiz(
            quizId
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 150,
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(imgUrl , width: MediaQuery.of(context).size.width -48
                , fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(title , style: TextStyle(color: Colors.white , fontSize: 17),),
                  SizedBox(height: 6,),
                  Text(desc, style: TextStyle(color: Colors.white , fontSize: 12),)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
