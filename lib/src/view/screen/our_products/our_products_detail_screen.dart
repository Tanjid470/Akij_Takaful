import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/helpers/context_value.dart';
import 'package:akij_login_app/src/model/products/ProductModel.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:flutter/material.dart';

class OurProductsDetailScreen extends StatelessWidget {
  final ProductModel product;

  const OurProductsDetailScreen(this.product, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const BaseAppBar(title: 'Our Products'),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: context.width,
                height: context.height * 0.30,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    image: DecorationImage(
                      image: NetworkImage(product.imageUrl.toString()),
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Text(product.name.toString(),
                    style: Theme.of(context).textTheme.displayLarge),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Text(
                  product.description.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 20,
                    right: 20,
                    bottom: 5,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    leading: const Icon(
                      Icons.summarize_rounded,
                      size: 45,
                      color: Colors.white60,
                    ),
                    tileColor: AppColors.bgCol,
                    title: Text(
                      product.productId == 7 ? "Premium" : "Sum Assured",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
                    ),
                    subtitle: Text(
                      product.sumAssured.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.white),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 5,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    leading: const Icon(
                      Icons.policy_rounded,
                      size: 45,
                      color: Colors.white60,
                    ),
                    tileColor: AppColors.bgCol,
                    title: Text(
                      "Policy Term",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
                    ),
                    subtitle: Text(
                      product.policyTerm.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.white),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 5,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    leading: const Icon(
                      Icons.payment_sharp,
                      size: 45,
                      color: Colors.white60,
                    ),
                    tileColor: AppColors.bgCol,
                    title: Text(
                      "Mode of Payment",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
                    ),
                    subtitle: Text(
                      product.mode.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.white),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 5,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    leading: const Icon(
                      Icons.timeline,
                      size: 45,
                      color: Colors.white60,
                    ),
                    tileColor: AppColors.bgCol,
                    title: Text(
                      "Age at Commencement",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
                    ),
                    subtitle: Text(
                      product.age.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.white),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    leading: const Icon(
                      Icons.more_time,
                      size: 45,
                      color: Colors.white60,
                    ),
                    tileColor: AppColors.bgCol,
                    title: Text(
                      "Age at Maturity",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white),
                    ),
                    subtitle: Text(
                      product.ageMax.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: AppColors.white),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Text(
                  "Benefits",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: ListTile(
                    title: Text(
                      "Maturity Benefit",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: AppColors.bgCol,
                              fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      product.maturityBenefit.toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    trailing: const Icon(
                      Icons.add_circle,
                      color: AppColors.bgCol,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: ListTile(
                    title: Text(
                      "Death Benefit",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: AppColors.bgCol,
                              fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      product.deathBenefit.toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    trailing: const Icon(
                      Icons.auto_delete_outlined,
                      color: AppColors.bgCol,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: ListTile(
                    title: Text(
                      "Supplementary Insurance Facility",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: AppColors.bgCol,
                              fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      product.supplementaryInsuranceFacility.toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    trailing: const Icon(
                      Icons.airline_seat_legroom_extra,
                      color: AppColors.bgCol,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: ListTile(
                    title: Text(
                      "Investment",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: AppColors.bgCol,
                              fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      product.investment.toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    trailing: const Icon(
                      Icons.inventory,
                      color: AppColors.bgCol,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: ListTile(
                    title: Text(
                      "Surrender and investment Facility",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: AppColors.bgCol,
                              fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      product.surrenderAndInvestmentFacility.toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    trailing: const Icon(
                      Icons.add_business,
                      color: AppColors.bgCol,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: ListTile(
                    title: Text(
                      "Paid up Value",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: AppColors.bgCol,
                              fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      product.paidUpValue.toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    trailing: const Icon(
                      Icons.app_settings_alt_rounded,
                      color: AppColors.bgCol,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  child: ListTile(
                    title: Text(
                      "Income Tax Rebate Facility",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color: AppColors.bgCol,
                              fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      product.incomeTaxRebateFacility.toString(),
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    trailing: const Icon(
                      Icons.auto_awesome,
                      color: AppColors.bgCol,
                    ),
                  )),
            ],
          ),
        ));
  }
}
