import 'package:flutter/material.dart';
import 'package:quizflutterapp/helper/functons.dart';
import 'package:quizflutterapp/views/home.dart';
import 'package:quizflutterapp/views/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool _isloggedin = false;

  @override
  void initState() {
    checkUserLoggedInStatus();
    super.initState();
  }

  checkUserLoggedInStatus() async{
    await HelperFunctions.getUserLoggedinDetails().then((value) {
      _isloggedin = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: (_isloggedin ?? false) ? Home() : SignIn(),
    );
  }
}
