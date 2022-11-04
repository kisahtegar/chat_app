import "package:flutter/material.dart";

import '../../../../const.dart';
import '../../widget/button_container_widget.dart';
import '../../widget/form_container_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst().backGroundColor,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Container(
            height: 550,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 48, 67, 102),
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 26, 26, 53),
                  blurRadius: 1,
                  spreadRadius: 2,
                  offset: Offset(4, 8),
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Column(
                children: [
                  // title login
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      color: ColorConst().primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                  sizeVer(30),

                  // Image signin logo
                  Image.asset(
                    "assets/images/signup-logo.png",
                    scale: 11,
                  ),
                  sizeVer(30),

                  // form container for Username
                  FormContainerWidget(
                    controller: _usernameController,
                    hintText: "Username",
                    iconsField: Icons.person,
                    topLeftRadius: const Radius.circular(50),
                    topRightRadius: const Radius.circular(50),
                    bottomLeftRadius: const Radius.circular(0),
                    bottomRightRadius: const Radius.circular(0),
                  ),
                  sizeVer(8),

                  // form container for E-Mail
                  FormContainerWidget(
                    controller: _emailController,
                    hintText: "E-Mail",
                    iconsField: Icons.mail,
                    topLeftRadius: const Radius.circular(0),
                    topRightRadius: const Radius.circular(0),
                    bottomLeftRadius: const Radius.circular(0),
                    bottomRightRadius: const Radius.circular(0),
                  ),
                  sizeVer(8),

                  // form container for Passowrd
                  FormContainerWidget(
                    controller: _passwordController,
                    hintText: "Password",
                    isPasswordField: true,
                    iconsField: Icons.password,
                    topLeftRadius: const Radius.circular(0),
                    topRightRadius: const Radius.circular(0),
                    bottomLeftRadius: const Radius.circular(50),
                    bottomRightRadius: const Radius.circular(50),
                  ),
                  sizeVer(15),

                  // Button Sign-In
                  const ButtonContainerWidget(
                    color: Colors.blue,
                    text: "Sign Up",
                  ),

                  Flexible(
                    flex: 2,
                    child: Container(),
                  ),

                  // warp to Sign-Up
                  const Divider(
                    height: 10,
                    thickness: 2,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have an account? ",
                        style: TextStyle(color: ColorConst().primaryColor),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            PageConst.signInPage,
                            (route) => false,
                          );
                        },
                        child: const Text(
                          "Sign In.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
