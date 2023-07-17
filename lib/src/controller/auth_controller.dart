import 'dart:convert';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_theme.dart';
import 'package:akij_login_app/helpers/get_tier_id.dart';
import 'package:akij_login_app/helpers/sharedPrefs.dart';
import 'package:akij_login_app/src/model/business/monthly_business_summary_model.dart';
import 'package:akij_login_app/src/model/policy/policy_info_model.dart';
import 'package:akij_login_app/src/model/policy/policy_list_summary_model.dart';

import 'package:akij_login_app/src/view/components/alert_box_builder.dart';
import 'package:akij_login_app/src/view/screen/auth/login/login_screen.dart';
import 'package:akij_login_app/src/view/screen/auth/signup/otp/otp_screen.dart';
import 'package:akij_login_app/src/view/screen/branch_offices/branch_offices_screen.dart';
import 'package:akij_login_app/src/view/screen/contact_us/contact_us_screen.dart';
import 'package:akij_login_app/src/view/screen/dashboard/component/dashboard_component.dart';
import 'package:akij_login_app/src/view/screen/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final String baseUrl = "https://api.atlplc.com/";
  final String policyUrl = "https://www.atlplc.com/Apps/ClientInfoForApps/";
  final String guestTokenApi = 'logindbbl';
  final String tokenApiUrl = "loginakij";

  static var token;
  static var guestToken;
  static String userType = '';
  static String user = '';
  static String userId = '';
  static String userPolicyNo = '';

  RxBool isLoading = false.obs;
  String pin1 = '';
  String pin2 = '';
  String pin3 = '';
  String pin4 = '';
  String pin5 = '';
  String pin6 = '';
  String totalPin = '';

  late PolicyInfoModel userInformation;
  final policyListSummary = PolicyListSummaryModel().obs;
  final monthlyBusinessSummary = MonthlyBusinessSummaryModel().obs;

  final usernameEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final phoneEditingController = TextEditingController();
  final codeEditingController = TextEditingController();

  Rx<ThemeData> theme = AppTheme.mainTheme.obs;

  final searchEditingController = TextEditingController();

  // policy summary
  RxString tier = "".obs;
  RxString code = "".obs;
  RxString totalPolicyNo = "".obs;
  RxString totalSumAssured = "".obs;
  RxString totalPremium = "".obs;
  RxString totalDuePolicies = "".obs;

  RxInt currentTab = 0.obs;
  RxBool loggedIn = false.obs;
  RxBool isPolicyHolder = false.obs;
  RxBool isProducer = false.obs;
  RxBool isAdmin = false.obs;
  RxBool dataExists = false.obs;
  double horizontalDrag = 0;

  List<String> userTypeList = [
    'PolicyHolder',
    'Producer',
    'Group',
    'Admin',
  ];
  Rx<String?> myUserType = Rx<String?>(null);

  void onChangedUserType(String value) => myUserType.value = value;

  List<Widget> pages = [
    const DashboardComponent(),
    const BranchOfficesScreen(),
    ContactUsScreen()
  ];

  void onItemTapped(value) {
    currentTab.value = value;
  }

  void checkLoggedIn() async {
    if (SharedPrefs().loggedIn == true) {
      loggedIn(true);
    } else {
      await getGuestToken();
      loggedIn(false);
    }
  }

  double calculateHeight() {
    if (isPolicyHolder.value) {
      return MediaQuery.of(Get.context as BuildContext).size.height * 0.17;
    } else if (isProducer.value) {
      return MediaQuery.of(Get.context as BuildContext).size.height * 0.48;
    } else {
      return MediaQuery.of(Get.context as BuildContext).size.height * 0.5;
    }
  }

  bool emailValid() {
    if (RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(emailEditingController.text)) {
      return true;
    }
    return false;
  }

  bool passwordMatches() {
    if (confirmPasswordEditingController.text ==
        passwordEditingController.text) {
      return true;
    } else {
      return false;
    }
  }

  getToken() {
    return SharedPrefs().token;
  }

  getGuestToken() async {
    await guestLogIn(guestTokenApi);
    return guestToken;
  }

  Future<void> refreshToken() async {
    await genToken();
    SharedPrefs().tokenPeriod = DateTime.now().toString();
  }

  getUsername() {
    return user.isNotEmpty ? user : SharedPrefs().username;
  }

  getUserId() {
    return userId.isNotEmpty ? userId : SharedPrefs().userId;
  }

  getUserType() {
    return userType.isNotEmpty ? userType : SharedPrefs().userType;
  }

  getDesignation() {
    return SharedPrefs().designation;
  }

  getPolicyNo() {
    return SharedPrefs().policyNo;
  }

  Future<void> login(BuildContext context) async {
    try {
      if (passwordEditingController.text.isNotEmpty &&
          usernameEditingController.text.isNotEmpty) {
        AlertBoxBuilder.circularProgressAlertBox(
            Get.context as BuildContext, "Please Wait");
        isLoading(true);
        await refreshToken();

        var res = await http.post(
          Uri.parse('${baseUrl}v1/Apps/LoginAuth'),
          headers: {
            'token': getToken(),
          },
          body: {
            "Username": usernameEditingController.text,
            "Password": passwordEditingController.text
          },
        );

        var body = json.decode(res.body);

        Get.back();

        if (res.statusCode == 200) {
          body = body[0];
          var status = body['errCode'];

          if (status == "0") {
            var result = body['result'][0];
            bool isActive = result['IsActive'];

            if (isActive) {
              updateTokenPeriod();

              updateUserType(result);

              updateIdentityNo(result);

              await updateUsername(result);

              updateLoginStatus();

              clearLoginCredentials();

              Get.to(() => const DashboardScreen());
            } else {
              AlertBoxBuilder.alertBox(
                  Get.context as BuildContext,
                  "Inactive",
                  "User is not active anymore!",
                  "Exit",
                  Colors.red,
                  Colors.red,
                  Icons.cancel_outlined);
            }
          } else {
            AlertBoxBuilder.alertBox(
                Get.context as BuildContext,
                "Invalid",
                "Invalid Credentials",
                "Try Again",
                Colors.red,
                Colors.red,
                Icons.close_rounded);
          }
        } else {
          AlertBoxBuilder.alertBox(
              Get.context as BuildContext,
              "Error!",
              "Please contact admin",
              "Try Again",
              Colors.red,
              Colors.red,
              Icons.close_rounded);
        }
      } else {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Blank",
            "Blank field not allowed",
            "Try Again",
            Colors.red,
            Colors.red,
            Icons.close_rounded);
      }
    } catch (e) {
      debugPrint(e.toString());
      throw Exception(e);
    } finally {
      isLoading(false);
    }
  }

  void clearLoginCredentials() {
    usernameEditingController.clear();
    passwordEditingController.clear();
  }

  void updateLoginStatus() {
    loggedIn(true);
    SharedPrefs().loggedIn = true;
  }

  Future<void> updateUsername(result) async {
    if (userType == "Admin" || userType == "Agent") {
      SharedPrefs().username = result['FirstName'];
      user = SharedPrefs().username;

      SharedPrefs().userId = result['UserName'].toString();
      userId = SharedPrefs().userId;
    } else {
      userInformation = await producerInfo(userPolicyNo);
      if (userInformation.name != null) {
        SharedPrefs().userId = result['UserName'].toString();
        userId = SharedPrefs().userId;

        SharedPrefs().username = userInformation.name!;
        user = SharedPrefs().username;
      }
    }
  }

  void updateTokenPeriod() {
    token = SharedPrefs().token;
    SharedPrefs().tokenPeriod = DateTime.now().toString();
  }

  void updateIdentityNo(result) {
    SharedPrefs().policyNo = result['IdentityNo'].toString();
    userPolicyNo = SharedPrefs().policyNo;
  }

  void updateUserType(result) {
    SharedPrefs().userType = result['UserType'];
    userType = SharedPrefs().userType;

    if (SharedPrefs().userType == 'PolicyHolder') {
      isPolicyHolder(true);
    } else if (SharedPrefs().userType == "Agent" ||
        SharedPrefs().userType == "Producer") {
      isProducer(true);
    } else if (SharedPrefs().userType == 'Admin') {
      isAdmin(true);
    }
  }

  void updateDesignation(tier) {
    int id = getTierId(tier);
    SharedPrefs().designation = id;
  }

  Future<PolicyInfoModel> producerInfo(String userPolicyNo) async {
    var response = await http.get(
      Uri.parse('${policyUrl}GetPolicyInfo?policyno=$userPolicyNo'),
    );
    var infoList = jsonDecode(response.body);

    PolicyInfoModel infoContent = PolicyInfoModel.fromJson(infoList);

    if (user.isEmpty || SharedPrefs().username.isEmpty) {
      SharedPrefs().username = infoContent.name.toString();
      user = SharedPrefs().username;
    }

    return infoContent;
  }

  getpolicyListSummary(String agentCode) async {
    try {
      if (agentCode.isNotEmpty) {
        dataExists(false);
        var response = await http
            .post(Uri.parse('${baseUrl}v1/Apps/PolicySummary'), headers: {
          'token': getToken(),
        }, body: {
          'Code': agentCode
        });

        if (response.statusCode == 401) {
          await refreshToken();
          getpolicyListSummary(agentCode);
        }

        if (response.statusCode == 200) {
          policyListSummary.value =
              PolicyListSummaryModel.fromJson(json.decode(response.body));

          updateDesignation(policyListSummary.value.tier);

          dataExists(true);
        }
      } else {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Empty Code",
            "Please enter a code!",
            'OK',
            Colors.red,
            Colors.red,
            Icons.close_rounded);
      }
    } catch (e) {
      debugPrint(e.toString());
      AlertBoxBuilder.alertBox(Get.context as BuildContext, "Error",
          "No List Found", 'OK', Colors.red, Colors.red, Icons.close_rounded);
    } finally {}

    return policyListSummary;
  }

  getMonthlyBusinessSummary() async {
    try {
      dataExists(false);
      var response = await http.get(
          Uri.parse('${baseUrl}v1/Apps/GetMonthlyBusinessSummary'),
          headers: {
            'token': getToken(),
          });

      if (response.statusCode == 401) {
        await refreshToken();
        getMonthlyBusinessSummary();
      }

      if (response.statusCode == 200) {
        monthlyBusinessSummary.value =
            MonthlyBusinessSummaryModel.fromJson(json.decode(response.body));

        dataExists(true);
      }
    } catch (e) {
      debugPrint(e.toString());
      AlertBoxBuilder.alertBox(Get.context as BuildContext, "Error",
          "No List Found", 'OK', Colors.red, Colors.red, Icons.close_rounded);
    } finally {}

    return policyListSummary;
  }

  guestLogIn(String apiUrl) async {
    var fullUrl = baseUrl + apiUrl;

    String username = "api";
    String password = "api";

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    var response = await http.post(
      Uri.parse(fullUrl),
      headers: <String, String>{
        'authorization': basicAuth,
      },
    );
    // _getToken();

    var str = response.body;
    guestToken = str.replaceAll('"', '');
    SharedPrefs().token = guestToken;
    var code = response.statusCode;

    return code;
  }

  Future<void> signup(BuildContext context) async {
    if (myUserType.value != 'Select User Type') {
      if (passwordMatches()) {
        if (emailValid()) {
          if (passwordEditingController.text.isNotEmpty &&
              confirmPasswordEditingController.text.isNotEmpty &&
              emailEditingController.text.isNotEmpty &&
              phoneEditingController.text.isNotEmpty &&
              codeEditingController.text.isNotEmpty) {
            AlertBoxBuilder.circularProgressAlertBox(
                Get.context as BuildContext, "Please Wait");

            var response = await http.post(
              Uri.parse('${baseUrl}v1/AkijWebsite/Registration'),
              headers: {
                'token': getToken(),
              },
              body: {
                'UserType': myUserType.value,
                'IdentityNo': codeEditingController.text,
                'Email': emailEditingController.text,
                'PhoneNo': phoneEditingController.text,
                'Password': passwordEditingController.text,
                'OTP': ""
              },
            );
            var data = json.decode(response.body);

            Get.back();

            if (data['errCode'] == "0") {
              Get.to(() => OtpScreen(
                  type: myUserType.value,
                  email: emailEditingController.text,
                  phoneNo: phoneEditingController.text,
                  code: codeEditingController.text,
                  password: passwordEditingController.text,
                  msg: data['message'],
                  token: getToken()));
            } else {
              AlertBoxBuilder.alertBox(
                  Get.context as BuildContext,
                  "Fail",
                  data['message'],
                  "Try Again",
                  Colors.red,
                  Colors.red,
                  Icons.close_rounded);
            }
          } else {
            AlertBoxBuilder.alertBox(
                Get.context as BuildContext,
                "Blank Field",
                "Blank Field Not Allowed",
                "OK",
                Colors.red,
                Colors.red,
                Icons.close);
          }
        } else {
          AlertBoxBuilder.alertBox(
              Get.context as BuildContext,
              "Invalid",
              "Email is not valid",
              "Try Again",
              Colors.blue,
              Colors.blue,
              Icons.info);
        }
      } else {
        AlertBoxBuilder.alertBox(
            Get.context as BuildContext,
            "Not Matching",
            "Passwords do not match",
            "Try Again",
            Colors.red,
            Colors.red,
            Icons.close_rounded);
      }
    } else {
      AlertBoxBuilder.alertBox(
          Get.context as BuildContext,
          "User Type",
          "Please Select a User Type",
          "Try Again",
          Colors.red,
          Colors.red,
          Icons.close_rounded);
    }
  }

  Future<void> registration(BuildContext context, String? type, String? code,
      String? email, String? phoneNo, String? password) async {
    totalPin = "$pin1$pin2$pin3$pin4$pin5$pin6".trim();

    isLoading(true);

    var response = await http.post(
      Uri.parse('${baseUrl}v1/AkijWebsite/RegistrationStep1'),
      headers: {
        'token': getToken(),
      },
      body: {
        'UserType': type,
        'IdentityNo': code,
        'Email': email,
        'PhoneNo': phoneNo,
        'Password': password,
        'OTP': totalPin
      },
    );
    var data = json.decode(response.body);

    isLoading(false);

    if (data['errCode'] == "0") {
      clearAllVars();

      actionAlert("Success", 'Registration Successful', 'Log In',
          Icons.done_outline_rounded, Colors.green, const LoginScreen());
    } else {
      AlertBoxBuilder.alertBox(
          Get.context as BuildContext,
          "Fail",
          data['message'],
          "Try Again",
          Colors.red,
          Colors.red,
          Icons.close_rounded);
    }
  }

  Future<void> genToken() async {
    var fullUrl = "$baseUrl$tokenApiUrl";

    String username = "api";
    String password = "api";

    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';

    var response = await http.post(
      Uri.parse(fullUrl),
      headers: <String, String>{
        'authorization': basicAuth,
      },
    );

    if (response.statusCode == 200) {
      var str = response.body;
      String json = str.replaceAll('"', '');
      SharedPrefs().token = json;
      token = SharedPrefs().token;
    } else {
      throw Exception();
    }
  }

  logOut() async {
    loggedIn(false);
    token = null;
    guestToken = null;
    user = "";
    userId = "";
    userPolicyNo = "";
    SharedPrefs().clear;
    loggedIn(false);
    isPolicyHolder(false);
    isAdmin(false);
    isProducer(false);
  }

  void onLogoutPressed() {
    showDialog(
      context: Get.context as BuildContext,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title:
              Text('Confirm!', style: Theme.of(context).textTheme.labelLarge),
          content: Text(
            'Are you sure you want to log out?',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'CANCEL',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: Text(
                'LOG OUT',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              onPressed: () {
                logOut();
                loggedIn(false);
                isPolicyHolder(false);
                isAdmin(false);
                isProducer(false);
                Navigator.of(context).pop();
                Get.to(() => const DashboardScreen());
              },
            ),
          ],
        );
      },
    );
  }

  void clearAllVars() {
    pin1 = '';
    pin2 = '';
    pin3 = '';
    pin4 = '';
    pin5 = '';
    pin6 = '';
    totalPin = '';
    myUserType = Rx<String?>(null);
    emailEditingController.clear();
    phoneEditingController.clear();
    codeEditingController.clear();
    passwordEditingController.clear();
    confirmPasswordEditingController.clear();
  }

  @override
  void onInit() async {
    checkLoggedIn();
    if (SharedPrefs().userType == 'PolicyHolder') {
      isPolicyHolder(true);
    } else if (SharedPrefs().userType == "Agent" ||
        SharedPrefs().userType == "Producer") {
      isProducer(true);
    } else if (SharedPrefs().userType == 'Admin') {
      isAdmin(true);
    }
    super.onInit();
  }

  @override
  void onClose() {
    myUserType = Rx<String?>(null);
    super.onClose();
  }
}
