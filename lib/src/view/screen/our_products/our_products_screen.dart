import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/src/controller/products_controller.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/src/view/screen/our_products/our_products_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OurProductsScreen extends StatelessWidget {
  const OurProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productsController = Get.put(ProductsController());

    return Scaffold(
      appBar: const BaseAppBar(title: 'Our Products'),
      body: Obx(
        () => ListView.builder(
            itemCount: productsController.productsList.length,
            itemBuilder: (BuildContext context, int index) {
              final item = productsController.productsList[index];

              return GestureDetector(
                onTap: () {
                  Get.to(() => OurProductsDetailScreen(item));
                },
                child: Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 35, top: 15, bottom: 15),
                    child: Stack(
                      children: [
                        Container(
                          height: 200,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45),
                                bottomLeft: Radius.circular(45)),
                            gradient: LinearGradient(
                              colors: [AppColors.primCol, AppColors.secCol],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(item.imageUrl),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  item.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.apply(color: Colors.white),
                                ),
                              ),
                              const Expanded(
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
