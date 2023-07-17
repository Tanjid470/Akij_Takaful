// ignore_for_file: prefer_if_null_operators
import 'dart:convert';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/constants/app_size.dart';
import 'package:akij_login_app/src/controller/auth_controller.dart';
import 'package:akij_login_app/src/model/hospital/hospital_model.dart';
import 'package:akij_login_app/src/view/components/alert_box_builder.dart';
import 'package:akij_login_app/src/view/components/large_button.dart';
import 'package:akij_login_app/helpers/sharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class StatefulBottomSheet extends StatefulWidget {
  final List<HospitalModel> items;
  final ValueChanged<List<HospitalModel>> valueChanged;

  const StatefulBottomSheet(
      {Key? key, required this.valueChanged, required this.items})
      : super(key: key);

  @override
  State<StatefulBottomSheet> createState() => _StatefulBottomSheetState();
}

class _StatefulBottomSheetState extends State<StatefulBottomSheet> {
  final authController = Get.find<AuthController>();

  late List<HospitalModel> _items;

  @override
  initState() {
    _items = widget.items;

    if (SharedPrefs().loggedIn == false) {
      getApiForGuest(context);
    }
    getDistrictList();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List? districtList;
  String? myDistrict;

  void getDistrictList() async {
    try {
      var response = await http.get(
        Uri.parse('${authController.baseUrl}v1/Apps/GetDistrict'),
        headers: {
          'token': authController.getToken(),
        },
      );

      if (response.statusCode == 401) {
        await authController.refreshToken();
        getDistrictList();
      }

      var data = json.decode(response.body);

      setState(() {
        districtList = data;
        myArea = null;
        areaList = null;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  List? areaList;
  String? myArea;

  void getAreaList(String? myDistrict) async {
    try {
      var response = await http.get(
        Uri.parse(
            "${authController.baseUrl}v1/Apps/GetDistrictArea/$myDistrict"),
        headers: {
          'token': authController.getToken(),
        },
      );

      if (response.statusCode == 401) {
        await authController.refreshToken();
        getAreaList(myDistrict);
      }

      var data = json.decode(response.body);

      if (!mounted) return;

      setState(() {
        areaList = data;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> showHospitalList() async {
    try {
      if (myDistrict == null) {
        AlertBoxBuilder.alertBox(
            context,
            "Error",
            "Please select any district",
            "Try Again",
            Colors.yellow.shade800,
            Colors.yellow.shade800,
            Icons.info);
      } else {
        var response = await http.post(
            Uri.parse('${authController.baseUrl}v1/Apps/HospitalList'),
            headers: {
              'token': authController.getToken()
            },
            body: {
              'DistCode': myDistrict,
              'policestation': myArea != null ? myArea : ""
            });

        if (response.statusCode == 401) {
          await authController.refreshToken();
          showHospitalList();
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
          _items = hospitals;
        });

        if (_items.isNotEmpty) {
          setState(() {
            _items = _items;
          });
          widget.valueChanged(_items);
          Navigator.pop(context);
        } else {
          AlertBoxBuilder.alertBox(context, "Error", "No Hospitals Found",
              "Try Again", Colors.red, Colors.red, Icons.close_rounded);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              width: MediaQuery.of(context).size.width * 0.90,
              decoration: BoxDecoration(
                color: AppColors
                    .textFieldGrey, //background color of dropdown button
                borderRadius:
                    BorderRadius.circular(AppSize.textFieldBorderRadius),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          itemHeight: 50,
                          isExpanded: true,
                          value: myDistrict,
                          iconSize: 30,
                          icon: (null),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          hint: const Text('Select District'),
                          onChanged: (String? newValue) {
                            setState(() {
                              myDistrict = newValue;
                              myArea = null;
                              getAreaList(myDistrict);
                            });
                          },
                          items: districtList?.map((item) {
                                return DropdownMenuItem(
                                  value: item['DistCode'].toString(),
                                  child: Text(item['DistName']),
                                );
                              }).toList() ??
                              [],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              width: MediaQuery.of(context).size.width * 0.90,
              decoration: BoxDecoration(
                color: AppColors
                    .textFieldGrey, //background color of dropdown button

                borderRadius:
                    BorderRadius.circular(AppSize.textFieldBorderRadius),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton<String>(
                          itemHeight: 50,
                          isExpanded: true,
                          value: myArea,
                          iconSize: 30,
                          icon: (null),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          hint: const Text('Select Area'),
                          onChanged: (String? newValue) {
                            setState(() {
                              myArea = newValue;
                            });
                          },
                          items: areaList?.map((item) {
                                return DropdownMenuItem(
                                  value: item['UpazillaCode'].toString(),
                                  child: Text(item['UpazillaName']),
                                );
                              }).toList() ??
                              [],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child: LargeButton(
                  btnText: "Show",
                  onPressed: () => {
                        {showHospitalList()}
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
