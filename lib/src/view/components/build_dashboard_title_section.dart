import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/helpers/context_value.dart';
import 'package:flutter/material.dart';

class BuildDashboardTitleSection extends StatelessWidget {
  final String title;
  final MainAxisAlignment align;

  const BuildDashboardTitleSection({
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
          padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 7.0),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.apply(color: AppColors.secCol, fontWeightDelta: 3),
          ),
        ),
      ],
    );
  }
}
