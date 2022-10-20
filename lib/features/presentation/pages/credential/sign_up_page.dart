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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            // logo image
            Image.asset('assets/images/logo.png'),
            sizeVer(30),
            //form container for Username
            FormContainerWidget(
              controller: _usernameController,
              hintText: "Username",
            ),
            sizeVer(15),
            // form container for E-Mail
            FormContainerWidget(
              controller: _emailController,
              hintText: "E-Mail",
            ),
            sizeVer(15),
            FormContainerWidget(
              controller: _passwordController,
              hintText: "Password",
              isPasswordField: true,
            ),
            sizeVer(15),
            const ButtonContainerWidget(
              color: Colors.blue,
              text: "Sign Up",
            ),
            Flexible(
              flex: 2,
              child: Container(),
            ),
            const Divider(
              height: 10,
              thickness: 2,
              color: Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "have an account? ",
                  style: TextStyle(color: ColorConst().primaryColor),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    "Sign In.",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorConst().primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
