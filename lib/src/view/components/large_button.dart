import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onPressed;

  const LargeButton({
    Key? key,
    required this.btnText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 30),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppSize.textFieldBorderRadius)),
          foregroundColor: Colors.white,
          backgroundColor: AppColors.butCol,
        ),
        onPressed: onPressed,
        child: Text(
          btnText.toUpperCase(),
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
