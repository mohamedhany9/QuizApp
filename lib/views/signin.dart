import 'package:flutter/material.dart';
import 'package:quizflutterapp/helper/functons.dart';
import 'package:quizflutterapp/services/auth.dart';
import 'package:quizflutterapp/views/home.dart';
import 'package:quizflutterapp/views/signup.dart';
import 'file:///C:/Users/M4TECH/AndroidStudioProjects/quiz_flutter_app/lib/widget/widget.dart';

class SignIn extends StatefulWidget {

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  String email, password;
  AuthService authService = new AuthService();
  bool _isLoading = false;

  signIn()async{
    if(_formKey.currentState.validate())
      {
        setState(() {
          _isLoading = true;
        });
        await authService.signInWithEmailandPass(email, password).then((value){
          if(value != null)
            {
              setState(() {
                _isLoading = false;
              });
                HelperFunctions.saveUserLoggedInDetails(isloggedin: true);
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => Home()
              ));
            }
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
      ),
      body: _isLoading ? Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ) : Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: <Widget>[
              Spacer(),
              TextFormField(
                validator: (val){return val.isEmpty ? "Enter Email Id" : null ;},
                decoration: InputDecoration(
                  hintText: "Email",
                ),
                onChanged: (val){
                  email = val;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                validator: (val){return val.isEmpty ? "Enter Password" : null ;},
                decoration: InputDecoration(
                  hintText: "Password",
                ),
                onChanged: (val){
                  password = val;
                },
              ),
              SizedBox(height: 24,),
              GestureDetector(
                onTap: (){
                  signIn();
                },
                child:blueButton(context, "Sign In"),
              ),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Don't have an account",style: TextStyle(fontSize: 15.5),),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => SignUp()
                      ));
                    },
                      child: Text("Sign Up",style: TextStyle(fontSize: 15.5,decoration: TextDecoration.underline),))
                ],
              ),
              SizedBox(height: 80,)
            ],
          ),
        ),
      ),
    );
  }
}
