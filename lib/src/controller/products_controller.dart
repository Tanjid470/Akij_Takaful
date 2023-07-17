import 'dart:convert';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/model/products/ProductModel.dart';
import 'package:akij_login_app/src/model/products/extra_model.dart';
import 'package:akij_login_app/src/model/products/ins_product_model.dart';
import 'package:akij_login_app/src/model/products/mode_model.dart';
import 'package:akij_login_app/src/model/products/terms_model.dart';
import 'package:akij_login_app/src/view/components/alert_box_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductsController extends GetxController {
  final authController = Get.find<AuthController>();

  late ProductModel productModel;

  RxList productsList = [].obs;
  var products = <InsProductModel>[].obs;
  Rx<InsProductModel?> selectedproduct = Rx<InsProductModel?>(null);
  var terms = <TermsModel>[].obs;
  Rx<TermsModel?> selectedTerm = Rx<TermsModel?>(null);
  var modes = <ModeModel>[].obs;
  Rx<ModeModel?> selectedMode = Rx<ModeModel?>(null);
  var extras = <ExtraModel>[].obs;
  Rx<ExtraModel?> selectedExtra = Rx<ExtraModel?>(null);

  getProducts() async {
    try {
      var response = await rootBundle.loadString("assets/json/products.json");

      if (response.isNotEmpty) {
        productsList.value = json.decode(response);
        productsList.value = RxList<ProductModel>.from(productsList.map((i) {
          return ProductModel.fromJson(i);
        }));
      } else {
        throw Exception("Error");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  getProductList() async {
    try {
      var response = await http.get(
        Uri.parse('${authController.baseUrl}v1/AkijWebsite/GetInsProduct'),
        headers: {
          'token': authController.getToken(),
        },
      );

      if (response.statusCode == 401) {
        await authController.refreshToken();
        getProductList();
      }

      final productsJson = jsonDecode(response.body) as List<dynamic>;
      final products = productsJson
          .map((officeJson) =>
              InsProductModel.fromJson(officeJson as Map<String, dynamic>))
          .toList();
      this.products.assignAll(products);
    } catch (e) {
      debugPrint(e.toString());
      AlertBoxBuilder.alertBox(
          Get.context as BuildContext,
          "Error",
          "Could not fetch list!",
          'OK',
          Colors.red,
          Colors.red,
          Icons.close_rounded);
    }
  }

  void onProductSelected(InsProductModel product) {
    selectedproduct.value = product;
  }

  getTermsList() async {
    try {
      var response = await http.get(
          Uri.parse(
              "${authController.baseUrl}v1/AkijWebsite/GetInsProductTerm/${selectedproduct.value?.table}"),
          headers: {
            'token': authController.getToken(),
          });

      if (response.statusCode == 401) {
        await authController.refreshToken();
        getTermsList();
      }

      final termsJson = jsonDecode(response.body) as List<dynamic>;
      final terms = termsJson
          .map((officeJson) =>
              TermsModel.fromJson(officeJson as Map<String, dynamic>))
          .toList();
      this.terms.assignAll(terms);
    } catch (e) {
      debugPrint(e.toString());
      AlertBoxBuilder.alertBox(
          Get.context as BuildContext,
          "Error",
          "Could not fetch terms list!",
          'OK',
          Colors.red,
          Colors.red,
          Icons.close_rounded);
    }
  }

  void onTermSelected(TermsModel term) {
    selectedTerm.value = term;
  }

  getModeList() {
    String jsonString = '';
    if (selectedproduct.value!.table != '09') {
      jsonString = '''
    [
      {"Value": "Mly", "Text": "Monthly"},
      {"Value": "Qly", "Text": "Quarterly"},
      {"Value": "Hly", "Text": "Half Yearly"},
      {"Value": "Yly", "Text": "Yearly"},
      {"Value": "Single", "Text": "Single"}
    ]
  ''';
    } else {
      jsonString = '''
    [
      {"Value": "Mly", "Text": "Monthly"}
    ]
  ''';
    }

    final modes = (jsonDecode(jsonString) as List<dynamic>)
        .map((item) => ModeModel.fromJson(item))
        .toList();
    this.modes.assignAll(modes);
  }

  void onModeSelected(ModeModel mode) {
    selectedMode.value = mode;
    print(selectedMode.value!.value);
  }

  getPdabList() {
    const data = '''
    [
      {"Table": "ADDB", "Name": "AD&D"},
      {"Table": "ADB", "Name": "ADB"}
    ]
    ''';

    final extras = (jsonDecode(data) as List<dynamic>)
        .map((item) => ExtraModel.fromJson(item))
        .toList();
    this.extras.assignAll(extras);
  }

  void onExtraSelected(ExtraModel extra) {
    selectedExtra.value = extra;
    print(selectedExtra.value!.table);
  }

  @override
  void onInit() async {
    await getProducts();
    super.onInit();
  }
}
