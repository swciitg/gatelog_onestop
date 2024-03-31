import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginStore {
  static Map<String, dynamic> userData = {};
  static bool isGuest = false;

  bool get isGuestUser {
    return isGuest;
  }

  static Future<bool> saveToUserData() async {
    // gets user data stored in local storage
    print("saveToUserData called");
    SharedPreferences instance = await SharedPreferences.getInstance();
    userData = jsonDecode(instance.getString("userInfo")!);
    userData["email"] = userData["outlookEmail"];
    return true;
  }
}
