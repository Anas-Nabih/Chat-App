import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({required this.hintText});

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration:  InputDecoration(
        hintText:hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder:const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        border:const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder:const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }
}