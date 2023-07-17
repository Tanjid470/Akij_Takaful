import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardItem extends StatefulWidget {
  final Widget route;
  final IconData icon;
  final Color color;
  final String title;
  final bool loginNeeded;

  const DashboardItem({
    Key? key,
    required this.route,
    required this.icon,
    required this.color,
    required this.title,
    required this.loginNeeded,
  }) : super(key: key);

  @override
  State<DashboardItem> createState() => _DashboardItemState();
}

class _DashboardItemState extends State<DashboardItem> {
  late String token;

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
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: Colors.black,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Get.to(() => widget.route);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  size: MediaQuery.of(context).size.width * 0.1,
                  color: widget.color,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(2),
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    softWrap: false,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.width * 0.027,
                        wordSpacing: -1.0,
                        letterSpacing: -0.09),
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
