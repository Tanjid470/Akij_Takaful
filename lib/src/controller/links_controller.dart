import 'package:akij_login_app/constants/app_asset.dart';
import 'package:akij_login_app/src/model/out_link/app_info_model.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/state_manager.dart';
import 'package:open_store/open_store.dart';
import 'package:url_launcher/url_launcher.dart';

class LinksController extends GetxController {
  final items = [
    AppInfoModel(
      "Islamic Life",
      AppAsset.life,
      "com.islami_jindegi",
      "1271205014",
    ),
    AppInfoModel(
      "Quran Mazid",
      AppAsset.quran,
      "com.ihadis.quran",
      "1324615850",
    ),
    AppInfoModel(
      "Al Hadith",
      AppAsset.book,
      "com.ihadis.ihadis",
      "1238182914",
    ),
    AppInfoModel(
      "Dua & Ruqyah",
      AppAsset.prayer,
      "com.ihadis.dua",
      "1568942398",
    ),
  ];

  onTapApp(int index) async {
    OpenStore.instance.open(
      appStoreId: items[index].iosLink,
      androidAppBundleId: items[index].androidLink,
    );
  }

  launchWebsite() async {
    var url = Uri.parse("https://www.akijtakafullife.com.bd/");
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }

  launchPolicyAltForm() async {
    var url = Uri.parse(
        "https://www.akijtakafullife.com.bd/download/policy/alternation/form");
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }

  launchIndGroupForm() async {
    var url =
        Uri.parse("https://www.akijtakafullife.com.bd/cliam_individual_form");
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }

  launchClaimGroupForm() async {
    var url = Uri.parse("https://www.akijtakafullife.com.bd/cliam_group_form");
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }

  launchImageGallery() async {
    var url = Uri.parse("https://www.akijtakafullife.com.bd/gallery/image");
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }

  launchVideoGallery() async {
    var url = Uri.parse("https://www.akijtakafullife.com.bd/gallery/video");
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw 'Could not launch $url';
    }
  }
}
