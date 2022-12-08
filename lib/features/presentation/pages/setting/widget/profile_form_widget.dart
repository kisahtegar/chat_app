import 'package:chat_app/const.dart';
import 'package:flutter/material.dart';

class ProfileFormWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? title;
  const ProfileFormWidget({
    Key? key,
    this.title,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: TextStyle(color: ColorConst().primaryColor, fontSize: 16),
        ),
        sizeVer(10),
        TextFormField(
          controller: controller,
          style: TextStyle(color: ColorConst().primaryColor),
          decoration: InputDecoration(
            border: InputBorder.none,
            labelStyle: TextStyle(color: ColorConst().primaryColor),
          ),
        ),
        // For Divider
        Container(
          width: double.infinity,
          height: 1,
          color: ColorConst().secondaryColor,
        ),
      ],
    );
  }
}
