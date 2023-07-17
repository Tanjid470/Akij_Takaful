import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/helpers/context_value.dart';
import 'package:flutter/material.dart';

class BuildFormTitleSection extends StatelessWidget {
  final String title;
  final MainAxisAlignment align;

  const BuildFormTitleSection({
    Key? key,
    required this.title,
    required this.align,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: align,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 16.0, bottom: 15),
          child: Text(
            title,
            style: Theme.of(context).textTheme.displayMedium,
          ),
        ),
      ],
    );
  }
}
