import 'package:akij_login_app/helpers/context_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PaymentButton extends StatelessWidget {
  final String logo;
  final String title;
  final VoidCallback onPressed;

  const PaymentButton({
    Key? key,
    this.logo = '',
    this.title = '',
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 27),
              blurRadius: 27,
              spreadRadius: -23,
              color: Colors.black,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (logo.isNotEmpty) ...[
                  if (logo.endsWith('.svg')) ...[
                    SvgPicture.asset(
                      logo,
                      height: 60,
                      width: 60,
                    ),
                  ] else ...[
                    Image.asset(
                      logo,
                      height: 80,
                      width: 80,
                    ),
                  ],
                ],
                if (title.isNotEmpty)
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: context.width * 0.045,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
