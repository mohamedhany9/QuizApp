import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {
  static String userLoggedInKey = "USERLOGGEDINKEY";

  static saveUserLoggedInDetails({@required bool isloggedin}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(userLoggedInKey, isloggedin);
  }

  static Future<bool> getUserLoggedinDetails()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(userLoggedInKey);
  }
}
