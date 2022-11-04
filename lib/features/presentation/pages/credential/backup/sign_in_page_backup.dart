import 'package:chat_app/const.dart';
import 'package:flutter/material.dart';

import '../../../widget/button_container_widget.dart';
import '../../../widget/form_container_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
              text: "Sign In",
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
                  "Don't have and account? ",
                  style: TextStyle(color: ColorConst().primaryColor),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      PageConst.signUpPage,
                      (route) => false,
                    );
                  },
                  child: Text(
                    "Sign Up.",
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
