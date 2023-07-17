// ignore_for_file: prefer_if_null_operators

import 'package:akij_login_app/constants/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final IconData? icon;
  final bool password;
  final Color? color;
  final bool isNum;
  final bool readOnly;

  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.icon,
    this.password = false,
    this.color = Colors.white70,
    this.isNum = false,
    this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Material(
        elevation: 0,
        shadowColor: Colors.black87,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppSize.textFieldBorderRadius),
        child: TextField(
          obscureText: password ? true : false,
          controller: controller,
          readOnly: readOnly,
          keyboardType: isNum ? TextInputType.number : TextInputType.text,
          inputFormatters: <TextInputFormatter>[
            isNum
                ? FilteringTextInputFormatter.digitsOnly
                : FilteringTextInputFormatter.singleLineFormatter,
          ],
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
            isDense: true,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppSize.textFieldBorderRadius),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: color,
            hintText: hintText,
            prefixIcon: Icon(icon != null ? icon : null),
          ),
        ),
      ),
    );
  }
}
