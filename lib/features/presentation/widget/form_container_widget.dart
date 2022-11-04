import 'package:flutter/material.dart';

import '../../../const.dart';

class FormContainerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? inputType;
  final Radius? topLeftRadius;
  final Radius? topRightRadius;
  final Radius? bottomLeftRadius;
  final Radius? bottomRightRadius;
  final IconData? iconsField;

  const FormContainerWidget({
    Key? key,
    this.controller,
    this.fieldKey,
    this.isPasswordField,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,
    this.inputType,
    this.topLeftRadius,
    this.topRightRadius,
    this.bottomLeftRadius,
    this.bottomRightRadius,
    this.iconsField,
  }) : super(key: key);

  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 10,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 35, 43, 59),
        borderRadius: BorderRadius.only(
          topLeft: widget.topLeftRadius!,
          topRight: widget.topRightRadius!,
          bottomLeft: widget.bottomLeftRadius!,
          bottomRight: widget.bottomLeftRadius!,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: TextFormField(
          key: widget.fieldKey,
          controller: widget.controller,
          keyboardType: widget.inputType,
          obscureText: widget.isPasswordField == true ? _obscureText : false,
          onSaved: widget.onSaved,
          validator: widget.validator,
          onFieldSubmitted: widget.onFieldSubmitted,
          style: TextStyle(color: ColorConst().primaryColor),
          decoration: InputDecoration(
            icon: Icon(
              widget.iconsField,
              color: Colors.blue,
            ),
            fillColor: Colors.transparent,
            border: InputBorder.none,
            filled: true,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: ColorConst().secondaryColor),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
              child: widget.isPasswordField == true
                  ? Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                      color: _obscureText == false
                          ? Colors.blue
                          : ColorConst().secondaryColor,
                    )
                  : const Text(""),
            ),
          ),
        ),
      ),
    );
  }
}
