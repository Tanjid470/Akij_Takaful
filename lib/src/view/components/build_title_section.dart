import 'package:flutter/material.dart';

class BuildTitleSection extends StatelessWidget {
  final String title;
  final String subTitle;
  final CrossAxisAlignment align;

  const BuildTitleSection({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.align,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 16.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
          child: Text(
            subTitle,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.apply(color: Colors.black45),
          ),
        )
      ],
    );
  }
}
