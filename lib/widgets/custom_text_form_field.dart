import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({this.validation,this.onChanged,required this.hintText});

  final String hintText;
  Function(String)? onChanged;
  FormFieldValidator<String>? validation;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged ?? (val){},
      validator: validation ?? (val){},
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
      ),
    );
  }
}
