import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<bool> isGuestUser() async {
    SharedPreferences instance = await SharedPreferences.getInstance();

    return instance.getBool("isGuest") ?? true;
  }
}
