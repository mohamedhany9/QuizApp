import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizflutterapp/model/user.dart';

class AuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  User _userfromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Future signInWithEmailandPass(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userfromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpWithEmailandPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userfromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut()async{
    try{
      return _auth.signOut();
    }catch(e)
    {
      print(e.toString());
      return null;
    }
  }
}
