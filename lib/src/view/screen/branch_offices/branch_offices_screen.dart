import 'package:akij_login_app/src/view/components/navbar/base_app_bar.dart';
import 'package:akij_login_app/src/view/components/navbar/navbar.dart';
import 'package:akij_login_app/constants/app_colors.dart';
import 'package:akij_login_app/src/view/components/alert_box_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class BranchOfficesScreen extends StatefulWidget {
  const BranchOfficesScreen({Key? key}) : super(key: key);

  @override
  State<BranchOfficesScreen> createState() => _BranchOfficesScreenState();
}

class _BranchOfficesScreenState extends State<BranchOfficesScreen> {
  List<Marker> markers = <Marker>[
    //  Divisional Offices
    Marker(
      point: LatLng(23.7357308, 90.4153083),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(
              ctx,
              "Head Office",
              "Paltan China Town ( 15th Floor), East Tower, 67/1 Naya Paltan, VIP Road, Dhaka-1000",
              AppColors.bgCol,
              Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.red.shade800,
          size: 50,
        ),
      ),
    ),
    Marker(
      point: LatLng(23.6930622, 90.4337709),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(
              ctx,
              "Dhaka South Divisional Office",
              "1/B, Jurain Rahman Plaza (2nd Floor), Kadamtali, Dhaka-1204"
                  "\n\nMobile: +8801894952606",
              AppColors.bgCol,
              Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.blue.shade800,
          size: 50,
        ),
      ),
    ),
    Marker(
      point: LatLng(22.8205238, 89.5510079),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(
              ctx,
              "Khulna Divisional Office",
              "Tribiun Tower (7th Floor), 2/B, K.D.A Evenue, Khulna."
                  "\n\nMobile: +8801894952612",
              AppColors.bgCol,
              Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.blue.shade800,
          size: 50,
        ),
      ),
    ),
    Marker(
      point: LatLng(22.7211299, 90.3375573),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(
              ctx,
              "Barishal Divisional Office",
              "Akter Mansion (3rd Floor, West side), 725, North Shagardi, C&B, Ward-14, Barishal."
                  "\n\nMobile: +8801894952604",
              AppColors.bgCol,
              Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.blue.shade800,
          size: 50,
        ),
      ),
    ),
    Marker(
      point: LatLng(23.632067, 90.4960898),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(
              ctx,
              "Narayangonj Divisional Office",
              "Khapur Mouja (2nd Floor), S.P near Office, Adarsha Chashara Road, NarayanGanj"
                  "\n\nMobile: +8801894952611",
              AppColors.bgCol,
              Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.blue.shade800,
          size: 50,
        ),
      ),
    ),
    Marker(
      point: LatLng(23.4606102, 91.1771037),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(
              ctx,
              "Cumilla Divisional Office",
              "Azanta Tower (level 5th), 363/1, Jhautola main road, Cumilla."
                  "\n\nMobile: +8801894952607",
              AppColors.bgCol,
              Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.blue.shade800,
          size: 50,
        ),
      ),
    ),
    Marker(
      point: LatLng(23.0092685, 91.3962965),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(
              ctx,
              "Feni Divisional Office",
              "Maisha A.M. Ahmed Tower(5th Floor), Shahid Shahidullah Kaiser Sharak, Feni"
                  "\n\nMobile: +8801894952622",
              AppColors.bgCol,
              Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.blue.shade800,
          size: 50,
        ),
      ),
    ),
    Marker(
      point: LatLng(25.7324411, 89.2546478),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(
              ctx,
              "Rangpur Divisional Office",
              "Shah Mir Quashem Plaza (3rd floor), Uttar Chartola More, College More, Alamnagar, Rangpur."
                  "\n\nMobile: +8801894952626",
              AppColors.bgCol,
              Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.blue.shade800,
          size: 50,
        ),
      ),
    ),
    Marker(
      point: LatLng(22.8707158, 91.0966437),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(
              ctx,
              "Noakhali Divisional Office",
              "Ashfaq Plaza (3rd floor), Maizdi, Noakhali.",
              AppColors.bgCol,
              Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.blue.shade800,
          size: 50,
        ),
      ),
    ),
    Marker(
      point: LatLng(24.7578903, 90.4093541),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(
              ctx,
              "Mymensingh Divisional Office",
              "34 no. Muktijoddha Sharani (3rd floor), Choto Bazar Sadar, Mymenshingh."
                  "\n\nMobile: +8801894952613",
              AppColors.bgCol,
              Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.blue.shade800,
          size: 50,
        ),
      ),
    ),
    Marker(
      point: LatLng(24.8579019, 89.3644774),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(
              ctx,
              "Bogura Divisional Office",
              "Bogura Bitu Tower (Level- 5), Bogura Road (Boogola), South Katner Para, Bogura.",
              AppColors.bgCol,
              Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.blue.shade800,
          size: 50,
        ),
      ),
    ),
    Marker(
      point: LatLng(23.553409, 89.1742646),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(
              ctx,
              "Jhenaidaha Divisional Office",
              "Munshi Emdad Super Market (1st Floor), Dukhi Mahmud Sharak, Arappur, Jhenaidaha"
                  "\n\nMobile: +8801894952614",
              AppColors.bgCol,
              Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.blue.shade800,
          size: 50,
        ),
      ),
    ),
    Marker(
      point: LatLng(24.369516, 88.6063095),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(
              ctx,
              "Rajshahi Divisional Office",
              "House: 224/225, Balighata House(2nd Floor), Sultanabad, Ghoramara-6100, Boalia, Rajshahi.",
              AppColors.bgCol,
              Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.blue.shade800,
          size: 50,
        ),
      ),
    ),
    Marker(
      point: LatLng(22.3687689, 91.8334725),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(
              ctx,
              "Chottogram Divisional Office",
              "Karim’s Icon Commercial Complex(8th Floor), Muradpur, Chottogram\n\nMobile: +8801894952610",
              AppColors.bgCol,
              Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.blue.shade800,
          size: 50,
        ),
      ),
    ),
    Marker(
      point: LatLng(23.5323176, 90.7085358),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(
              ctx,
              "Cumilla South Office",
              "Daudkandi\n\nMobile: +8801894952621",
              AppColors.bgCol,
              Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.blue.shade800,
          size: 50,
        ),
      ),
    ),
    Marker(
      point: LatLng(23.8769072, 90.3573083),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(ctx, "Dhaka North Office",
              "Uttara\n\n Mobile: +8801894952617", AppColors.bgCol, Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.blue.shade800,
          size: 50,
        ),
      ),
    ),

    //  Service Cell
    Marker(
      point: LatLng(23.4881232, 89.4117164),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(ctx, "Magura Service Cell", "Magura",
              AppColors.bgCol, Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.yellow.shade800,
          size: 50,
        ),
      ),
    ),
    Marker(
      point: LatLng(22.7145193, 89.0527129),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(
              ctx,
              "Satkhira Service Cell",
              "Z PLAZA (3RD FLOOR), NEW MARKET ROAD, SATKHIRA",
              AppColors.bgCol,
              Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.yellow.shade800,
          size: 50,
        ),
      ),
    ),
    Marker(
      point: LatLng(24.587647, 88.284604),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(
              ctx,
              "Chapainababgonj Service Cell",
              "SONAMONIA HOUSE (1ST FLOOR), SHAWRUPNAGAR, CHAPAI NAWABGANJ.",
              AppColors.bgCol,
              Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.yellow.shade800,
          size: 50,
        ),
      ),
    ),
    Marker(
      point: LatLng(23.490117, 89.420360),
      width: 80,
      height: 80,
      builder: (ctx) => GestureDetector(
        onTap: () {
          AlertBoxBuilder.mapAlertBox(ctx, "Magura Service Cell",
              "ALAM COMPLEX, M.R. ROAD, MAGURA", AppColors.bgCol, Icons.info);
        },
        child: Icon(
          Icons.location_on,
          color: Colors.yellow.shade800,
          size: 50,
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const BaseAppBar(title: 'Branch Offices'),
      drawer: const Navbar(),
      body: Center(
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(23.777176, 90.399452),
                  zoom: 7,
                  minZoom: 7,
                  maxZoom: 16,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                  MarkerLayer(markers: markers),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
