// ignore_for_file: prefer_if_null_operators
import 'dart:convert';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/model/hospital/hospital_model.dart';
import 'package:akij_login_app/src/view/components/build_title_section.dart';
import 'package:akij_login_app/src/view/components/custom_circular_progress.dart';
import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/constants/app_asset.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/screens/hospital_list/widget/stateful_bottom_sheet.dart';
import 'package:akij_login_app/helpers/sharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HospitalListScreen extends StatefulWidget {
  const HospitalListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HospitalListScreen> createState() => _HospitalListScreenState();
}

class _HospitalListScreenState extends State<HospitalListScreen> {
  final authController = Get.find<AuthController>();

  bool hospitalLoading = false;
  List<HospitalModel> items = [];

  @override
  void initState() {
    super.initState();
    if (SharedPrefs().loggedIn == false) {
      getApiForGuest(context);
    }
    getDefaultHospitalList();
  }

  dynamic hospitalListState(List<HospitalModel> list) {
    setState(() {
      items = list;
    });
  }

  Future<void> getApiForGuest(BuildContext context) async {
    var token = await authController.getGuestToken();

    if (token == null) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.close_rounded,
                      size: 20,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Server Error',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    )
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll(AppColors.slightRed),
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)))),
                    onPressed: () => Navigator.pop(context, 'Close'),
                    child: const Center(
                      child: Text(
                        'Close',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  )
                ],
              ));
    }
  }

  Future<void> getDefaultHospitalList() async {
    try {
      setState(() {
        hospitalLoading = true;
      });

      var response = await http.post(
          Uri.parse('${authController.baseUrl}v1/Apps/HospitalList'),
          headers: {'token': authController.getToken()},
          body: {'DistCode': '13', 'policestation': ''});

      if (response.statusCode == 401) {
        await authController.refreshToken();
        getDefaultHospitalList();
      }

      var data = json.decode(response.body);

      List<HospitalModel> hospitals = [];

      for (var hospitalInfo in data) {
        HospitalModel hospital = HospitalModel(
          id: hospitalInfo['Id'],
          hospitalCode: hospitalInfo['HospitalCode'],
          hospitalName: hospitalInfo['HospitalName'],
          hospitalAddress: hospitalInfo['HospitalAddress'],
          distName: hospitalInfo['DistName'],
          policeStationName: hospitalInfo['PoliceStationName'],
          hospitalPhone: hospitalInfo['HospitalPhone'],
          hospitalArea: hospitalInfo['HospitalArea'],
          facilities: hospitalInfo['Facilities'],
        );

        hospitals.add(hospital);
      }

      setState(() {
        items = hospitals;
        hospitalLoading = false;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: const BaseAppBar(title: 'Hospitals'),
      backgroundColor: AppColors.secBgColor,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: BuildTitleSection(
                title: 'Available Hospitals',
                subTitle: "Start Searching",
                align: CrossAxisAlignment.start),
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppSize.textFieldBorderRadius),
              ),
              elevation: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            AppSize.textFieldBorderRadius)),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBottomSheet(
                            items: items,
                            valueChanged: hospitalListState,
                          );
                        });
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppAsset.search,
                          height: AppSize.iconHeight,
                          width: AppSize.iconWidth,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Search",
                          style: TextStyle(
                              fontSize: size.width * 0.04,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600),
                        ),
                      ]),
                ),
              ),
            ),
          ),
          hospitalLoading
              ? const CustomCircularProgress()
              : ListView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.all(12.0),
                      child: ListTile(
                        textColor: Colors.black,
                        tileColor: AppColors.white,
                        horizontalTitleGap: 20.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              AppSize.textFieldBorderRadius),
                        ),
                        contentPadding: const EdgeInsets.all(15),
                        minVerticalPadding: 10.0,
                        title: Text(
                          items[index].hospitalName.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: size.width * 0.045,
                          ),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                items[index].hospitalAddress.toString(),
                                style: TextStyle(fontSize: size.width * 0.04),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: items[index]
                                      .hospitalPhone
                                      .toString()
                                      .isNotEmpty
                                  ? Text(
                                      "Contact No: ${items[index].hospitalPhone.toString()}",
                                      style: TextStyle(
                                          fontSize: size.width * 0.04),
                                    )
                                  : null,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child:
                                  items[index].facilities.toString().isNotEmpty
                                      ? Text(
                                          "Facilities: ",
                                          style: TextStyle(
                                              fontSize: size.width * 0.04,
                                              fontWeight: FontWeight.w600),
                                        )
                                      : null,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: items[index]
                                      .facilities
                                      .toString()
                                      .isNotEmpty
                                  ? Html(
                                      style: {
                                        "body": Style(
                                            fontSize:
                                                FontSize(size.width * 0.04),
                                            color: Colors.black),
                                      },
                                      data: items[index].facilities.toString(),
                                    )
                                  : null,
                            ),
                          ],
                        ),
                        trailing:
                            items[index].hospitalPhone.toString().isNotEmpty
                                ? GestureDetector(
                                    onTap: () async {
                                      final call = Uri.parse(
                                          'tel:${items[index].hospitalPhone.toString()}');
                                      if (await canLaunchUrl(call)) {
                                        launchUrl(call);
                                      } else {
                                        throw 'Could not launch $call';
                                      }
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: AppColors.bgCol,
                                      child: Icon(
                                        Icons.call,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  )
                                : null,
                      ),
                    );
                  }),
        ]),
      ),
    );
  }
}
