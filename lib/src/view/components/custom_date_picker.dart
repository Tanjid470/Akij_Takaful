import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDatePicker extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final VoidCallback onTap;
  final String controllerText;
  final IconData icon;
  final bool password;
  final Color? color;
  final bool isNum;
  final bool readOnly;

  const CustomDatePicker({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.icon,
    this.password = false,
    this.color = Colors.white70,
    this.isNum = false,
    this.readOnly = false,
    required this.onTap,
    required this.controllerText,
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
          controller: TextEditingController(text: controllerText),
          readOnly: readOnly,
          onTap: onTap,
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
            prefixIcon: Icon(icon),
          ),
        ),
      ),
    );
  }
}

Future<DateTime?> customDatePickerColor(BuildContext context) {
  return showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.primCol,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.secCol,
            ),
          ),
        ),
        child: child!,
      );
    },
  );
}
