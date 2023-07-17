import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backColor,
        appBar: const BaseAppBar(title: 'About Us'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.30,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    image: DecorationImage(
                      image: const NetworkImage(
                        "https://www.akijtakafullife.com.bd/public/backend/assets/images/company_profile/About%20Us-1633321159-image.png",
                      ),
                      onError: (error, stackTrace) =>
                          Image.asset('assets/images/company_logo.png'),
                      fit: BoxFit.cover,
                    )),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Text(
                  "About Akij Takaful Life Insurance PLC",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Text(
                  "New and exciting ethical perspective to risk management in the Bangladesh Life Insurance Market, Akij Takaful Life Insurance started its operation in November 2021 to provide transparently and trusted insurance service to its customers. We believe in long term, reliable business relationship with our clients.",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    leading: const Icon(
                      Icons.info_sharp,
                      size: 45,
                      color: Colors.white60,
                    ),
                    tileColor: AppColors.tileColor,
                    title: const Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Text(
                        "Who We Are",
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                    ),
                    subtitle: const Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "Akij Takaful Life Insurance PLC is a fifth generation "
                        "pioneering and dynamic insurance company to provide"
                        " ethical and innovative products. At Takaful, we identify "
                        "that risk is an undeniable part of life. We provide a wide "
                        "range of risk management and financial security services. "
                        "The Takaful concept is predicated on the principles of togetherness,"
                        " cooperation and mutual solidarity for all. We are operated "
                        "on a principled and ethical foundation that aims to improve "
                        "societal welfare and avoids prohibited activities relating exploitative"
                        " interest, gambling and excessive uncertainty.",
                        style: TextStyle(
                            fontSize: 16,
                            wordSpacing: 3.0,
                            height: 1.5,
                            fontWeight: FontWeight.normal,
                            color: Colors.white),
                      ),
                    ),
                  )),
            ],
          ),
        ));
  }
}
