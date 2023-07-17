import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/src/view/components/custom_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlertBoxBuilder {
  static Future<void> alertBox(parentContext, title, descriptions, buttonText,
      buttonColor, iconColor, icon) {
    return showDialog(
        context: parentContext,
        builder: (BuildContext context) {
          return CustomAlert(
            title: title,
            descriptions: descriptions,
            buttonText: buttonText,
            buttonColor: buttonColor,
            iconColor: iconColor,
            icon: icon,
          );
        });
  }

  static Future<void> circularProgressAlertBox(parentContext, title) {
    return showDialog(
        context: parentContext,
        builder: (BuildContext context) {
          return CicularBox(
            title: title,
          );
        });
  }

  static Future<void> mapAlertBox(
      parentContext, title, descriptions, iconColor, icon) {
    return showDialog(
        context: parentContext,
        builder: (BuildContext context) {
          return MapAlert(
            title: title,
            descriptions: descriptions,
            iconColor: iconColor,
            icon: icon,
          );
        });
  }
}

class CustomAlert extends StatefulWidget {
  final String title, descriptions, buttonText;
  final Color buttonColor, iconColor;
  final IconData icon;

  const CustomAlert({
    super.key,
    required this.title,
    required this.descriptions,
    required this.buttonText,
    required this.buttonColor,
    required this.iconColor,
    required this.icon,
  });

  @override
  _CustomAlertState createState() => _CustomAlertState();
}

class _CustomAlertState extends State<CustomAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.borderRadius),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            size: 20,
            color: widget.iconColor,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            widget.descriptions,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.normal),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(widget.buttonColor),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)))),
          onPressed: () => {Navigator.pop(context)},
          child: Center(
            child: Text(
              widget.buttonText,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.alertActionText),
            ),
          ),
        ),
      ],
    );
  }
}

class CicularBox extends StatefulWidget {
  final String title;

  const CicularBox({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _CicularBoxState createState() => _CicularBoxState();
}

class _CicularBoxState extends State<CicularBox> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.borderRadius),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[CustomCircularProgress()],
      ),
    );
  }
}

class MapAlert extends StatefulWidget {
  final String title, descriptions;
  final Color iconColor;
  final IconData icon;

  const MapAlert({
    super.key,
    required this.title,
    required this.descriptions,
    required this.iconColor,
    required this.icon,
  });

  @override
  _MapAlertState createState() => _MapAlertState();
}

class _MapAlertState extends State<MapAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            size: 20,
            color: widget.iconColor,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            widget.title,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontWeight: FontWeight.w600),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            widget.descriptions,
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.copyWith(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

Future<dynamic> actionAlert(String title, String desc, String btnText,
    IconData icon, Color iconColor, Widget routeName) {
  return showDialog(
    context: Get.context as BuildContext,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: iconColor,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.w600),
            )
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              desc,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.normal),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              btnText,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: AppColors.bgCol),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              Get.offAll(() => routeName);
            },
          ),
        ],
      );
    },
  );
}
