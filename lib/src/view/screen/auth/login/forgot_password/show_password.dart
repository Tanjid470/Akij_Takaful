import 'package:akij_login_app/src/view/components/build_title_section.dart';
import 'package:akij_login_app/src/view/components/large_button.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/helpers/context_value.dart';
import 'package:akij_login_app/src/view/screen/auth/login/login_screen.dart';
import 'package:flutter/material.dart';

class ShowPassword extends StatelessWidget {
  final String password;

  const ShowPassword({Key? key, required this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BaseAppBar(title: ''),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BuildTitleSection(
                title: "Your Password is",
                subTitle: password,
                align: CrossAxisAlignment.center),
            SizedBox(
              height: context.height * 0.02,
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: LargeButton(
                  btnText: "Log In",
                  onPressed: () => {
                        {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen()))
                        }
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
