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
    print("here");
    SharedPreferences instance = await SharedPreferences.getInstance();
    userData = jsonDecode(instance.getString("userInfo")!);
    print(userData);
    userData["email"]=userData["outlookEmail"]; // fix this in next version use outlookEmail as keyword
    print(userData);
    print(isGuest);
    if((instance.getBool("isGuest")!)==true){
      isGuest=true;
    }
    else
      {
        isGuest = false;
      }
    return true;
  }

}
