import 'dart:math';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/model/policy/policy_info_model.dart';
import 'package:akij_login_app/src/view/components/custom_circular_progress.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyCardScreen extends StatefulWidget {
  const MyCardScreen({Key? key}) : super(key: key);

  @override
  State<MyCardScreen> createState() => _MyCardScreenState();
}

class _MyCardScreenState extends State<MyCardScreen>
    with SingleTickerProviderStateMixin {
  final authController = Get.find<AuthController>();

  late PolicyInfoModel cardInformation;
  bool infoLoaded = false;
  late AnimationController _controller;
  late Animation _animation;

  @override
  void initState() {
    callForPolicyInformation();
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> callForPolicyInformation() async {
    cardInformation =
        await authController.producerInfo(authController.getPolicyNo());

    setState(() {
      infoLoaded = true;
    });
  }

  void _flipCard() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const BaseAppBar(
          title: 'Card Details',
        ),
        body: infoLoaded
            ? SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildTitleSection(
                          title: "My Card", subTitle: "Card Information"),
                      GestureDetector(
                          onTap: _flipCard,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (BuildContext context, Widget? child) {
                              return Transform(
                                alignment: FractionalOffset.center,
                                transform: Matrix4.identity()
                                  ..setEntry(3, 2, 0.001)
                                  ..rotateX(pi * _animation.value),
                                child: Container(
                                  child: !_controller.isCompleted
                                      ? cardFront()
                                      : Transform(
                                          transform: Matrix4.identity()
                                            ..rotateX(pi * _animation.value),
                                          alignment: FractionalOffset.center,
                                          child: cardBack()),
                                ),
                              );
                            },
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Card(
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              _buildExtraInformation(
                                  title: "Name",
                                  detail: cardInformation.name.toString()),
                              _buildExtraInformation(
                                  title: "Account",
                                  detail: cardInformation.policyNo.toString()),
                              _buildExtraInformation(
                                  title: "Exp Date",
                                  detail:
                                      cardInformation.maturityDate.toString()),
                              _buildExtraInformation(
                                  title: "Due Date",
                                  detail:
                                      cardInformation.nextDueDate.toString()),
                              _buildExtraInformation(
                                  title: "Mode",
                                  detail: cardInformation.mode.toString()),
                              _buildExtraInformation(
                                  title: "Sum Assured",
                                  detail:
                                      cardInformation.sumassured.toString()),
                              _buildExtraInformation(
                                  title: "Total Premium",
                                  detail: cardInformation.totalPrem.toString()),
                              _buildExtraInformation(
                                  title: "Status",
                                  detail: cardInformation.status.toString()),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : const CustomCircularProgress());
  }

  Widget cardFront() {
    return _buildCreditCard(
        color: AppColors.bgCol,
        cardExpiration: cardInformation.maturityDate.toString(),
        cardHolder: authController.getUsername(),
        cardNumber: cardInformation.policyNo.toString());
  }

  Widget cardBack() {
    return _buildCreditCardBack(
        color: AppColors.bgCol,
        cardExpiration: cardInformation.maturityDate.toString(),
        cardHolder: authController.getUsername(),
        cardNumber: cardInformation.policyNo.toString());
  }

  // Build the title section
  Column _buildTitleSection({required title, required subTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 16.0),
          child: Text(
            '$title',
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, bottom: 16.0),
          child: Text(
            '$subTitle',
            style: const TextStyle(fontSize: 21, color: Colors.black45),
          ),
        )
      ],
    );
  }

  //  Build the sub section
  Card _buildCreditCard(
      {required Color color,
      required String cardNumber,
      required String cardHolder,
      required String cardExpiration}) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: context.height * 0.26,
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(),
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                "Akij Takaful Life Insurance PLC.",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'CourrierPrime'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                cardNumber,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'CourrierPrime'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(
                  label: 'CARDHOLDER',
                  value: cardHolder,
                ),
                _buildDetailsBlock(label: 'VALID THRU', value: cardExpiration),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build the credit card back
  Card _buildCreditCardBack(
      {required Color color,
      required String cardNumber,
      required String cardHolder,
      required String cardExpiration}) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        height: context.height * 0.26,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Container(
                height: context.height * 0.05,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: [
                      Container(
                        height: context.height * 0.04,
                        width: context.width / 1.5,
                        color: Colors.grey,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Text(
                          "421",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _buildDetailsBlock(
                          label: 'VALID THRU', value: cardExpiration),
                    ],
                  ),
                  const SizedBox(height: 5),
                  _buildLogosBlock(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build the top row containing logos
  Row _buildLogosBlock() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          "assets/images/company_logo_white.png",
          height: 45,
          width: context.width * 0.3,
        ),
        SvgPicture.asset(
          "assets/logo/visacard.svg",
          height: 40,
          width: 40,
        ),
      ],
    );
  }

  // Build Column containing the cardholder and expiration information
  Column _buildDetailsBlock({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
              color: Color.fromARGB(255, 228, 206, 206),
              fontSize: 9,
              fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  Padding _buildExtraInformation(
      {required String title, required String detail}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          title,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),
        ),
        Text(
          detail,
          style: const TextStyle(
              fontWeight: FontWeight.w600, fontSize: 15, color: Colors.black),
        ),
      ]),
    );
  }
}
