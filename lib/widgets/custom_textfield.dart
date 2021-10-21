import 'package:flutter/material.dart';
import 'package:interintel/config/app_config.dart';


class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final IconData? data;
  final String? hintText;
  final TextInputType? inputType;

  const CustomTextField(
      {Key? key, this.controller, this.data, this.hintText, this.inputType,})
      : super(key: key);

  //This is our custom designed TextFormField

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        controller: controller,
        keyboardType: inputType,
        cursorColor: InterIntel.themeColor,
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: const BorderSide(
                width: 1.0,
                color: InterIntel.themeColor
              )),
          prefixIcon: Icon(
            data,
            color: Colors.grey[400],
          ),
          focusColor: InterIntel.themeColor,
          hoverColor: InterIntel.themeColor,
          hintText: hintText,
          labelText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
