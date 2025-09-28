import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  TextFieldWidget({super.key, this.hintText, this.icon, this.controller});
  String? hintText;
  Icon? icon;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white70),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        hintStyle: TextStyle(
          fontSize: 15,
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
        hintText: hintText,
        suffixIcon: icon,
      ),
      cursorColor: Colors.grey,
      style: TextStyle(color: Colors.white),
    );
  }
}
