import 'dart:math';

import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/model/policy/policy_info_model.dart';
import 'package:akij_login_app/src/view/components/custom_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DashboardCard extends StatefulWidget {
  const DashboardCard({Key? key}) : super(key: key);

  @override
  State<DashboardCard> createState() => _DashboardCard();
}

class _DashboardCard extends State<DashboardCard>
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
    return infoLoaded
        ? Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
              ],
            ),
          )
        : const Center(child: CustomCircularProgress());
  }

  Widget cardFront() {
    return _buildCreditCard(
      color: AppColors.bgCol,
      cardExpiration: cardInformation.maturityDate.toString(),
      cardHolder: authController.getUsername(),
      cardNumber: cardInformation.policyNo.toString(),
      status: cardInformation.status.toString(),
    );
  }

  Widget cardBack() {
    return _buildCreditCardBack(
        color: AppColors.bgCol,
        cardExpiration: cardInformation.maturityDate.toString(),
        cardHolder: authController.getUsername(),
        cardNumber: cardInformation.policyNo.toString());
  }

  //  Build the sub section
  Card _buildCreditCard({
    required Color color,
    required String cardNumber,
    required String cardHolder,
    required String cardExpiration,
    required String status,
  }) {
    return Card(
      elevation: 4.0,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _buildLogosBlock(),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "Akij Takaful Life Insurance PLC.",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'CourrierPrime'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                cardNumber,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontFamily: 'CourrierPrime'),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(label: 'CARDHOLDER', value: cardHolder),
                _buildDetailsBlock(label: 'VALID THRU', value: cardExpiration),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildDetailsBlock(label: 'STATUS', value: status),
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
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
                      height: MediaQuery.of(context).size.height * 0.04,
                      width: MediaQuery.of(context).size.width / 1.5,
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
                const SizedBox(height: 10),
              ],
            ),
          ),
        ],
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
          width: MediaQuery.of(context).size.width * 0.3,
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
          style: TextStyle(
              color: const Color.fromARGB(255, 228, 206, 206),
              fontSize: MediaQuery.of(context).size.width * 0.025,
              fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width * 0.038,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
