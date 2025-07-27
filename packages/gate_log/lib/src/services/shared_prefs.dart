import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<bool> isGuestUser() async {
    SharedPreferences instance = await SharedPreferences.getInstance();
    bool isGuest = instance.getBool("isGuest") ?? true;
    print("Is Guest: (Gatelog) $isGuest");
    return isGuest;
  }
}
