import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ColorConst {
  Color backGroundColor = const Color.fromARGB(255, 45, 56, 77);
  Color primaryColor = Colors.white;
  Color secondaryColor = Colors.grey;
  Color darkGreyColor = const Color.fromRGBO(97, 97, 97, 1);
}

// Divider
Widget sizeVer(double height) {
  return SizedBox(height: height);
}

Widget sizeHor(double width) {
  return SizedBox(width: width);
}

// Page Route
class PageConst {
  static const String signInPage = 'signInPage';
  static const String signUpPage = 'signUpPage';
  static const String settingPage = 'settingPage';
}

// Firebase DB
class FirebaseConst {
  static const String users = 'users';
  static const String posts = 'posts';
  static const String comment = 'comment';
  static const String replay = 'replay';
}

// Toast message
void toast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.blue,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
