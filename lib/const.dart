import 'package:flutter/material.dart';

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
}
