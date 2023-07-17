import 'package:akij_login_app/constants/app_asset.dart';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTextWithSearch extends StatelessWidget {
  const CustomTextWithSearch(
      {super.key,
      required this.controller,
      required this.function,
      required,
      required this.hinText});

  final dynamic controller;
  final String hinText;
  final void Function() function;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 13, bottom: 10),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 0,
        child: TextField(
          style: const TextStyle(height: 1),
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            focusColor: AppColors.butCol,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(AppSize.textFieldBorderRadius),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(
                Radius.circular(AppSize.textFieldBorderRadius),
              ),
            ),
            filled: true,
            fillColor: AppColors.white,
            hintText: hinText,
            suffixIcon: IconButton(
              onPressed: function,
              icon: SvgPicture.asset(
                AppAsset.search,
                height: AppSize.iconHeight,
                width: AppSize.iconWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
