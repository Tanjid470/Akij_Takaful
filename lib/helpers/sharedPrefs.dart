import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  String get username => _sharedPrefs?.getString("username") ?? "";
  String get userId => _sharedPrefs?.getString("userId") ?? "";
  String get userType => _sharedPrefs?.getString("userType") ?? "";
  int get designation => _sharedPrefs?.getInt("designation") ?? 0;
  String get token => _sharedPrefs?.getString("token") ?? "";
  String get tokenPeriod => _sharedPrefs?.getString("tokenPeriod") ?? "";
  bool get loggedIn => _sharedPrefs?.getBool("loggedIn") ?? false;
  String get policyNo => _sharedPrefs?.getString("policyNo") ?? "";

  get clear => _sharedPrefs?.clear();

  set username(String value) {
    _sharedPrefs?.setString("username", value);
  }

  set userId(String value) {
    _sharedPrefs?.setString("userId", value);
  }

  set userType(String value) {
    _sharedPrefs?.setString("userType", value);
  }

  set designation(int value) {
    _sharedPrefs?.setInt("designation", value);
  }

  set token(String value) {
    _sharedPrefs?.setString("token", value);
  }

  set tokenPeriod(String value) {
    _sharedPrefs?.setString("tokenPeriod", value);
  }

  set loggedIn(bool value) {
    _sharedPrefs?.setBool("loggedIn", value);
  }

  set policyNo(String value) {
    _sharedPrefs?.setString("policyNo", value);
  }
}
