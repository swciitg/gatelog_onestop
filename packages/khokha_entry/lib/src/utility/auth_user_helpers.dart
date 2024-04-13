import 'package:onestop_kit/src/api/backend_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUserHelpers {
  static Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(BackendHelper.accesstoken) ?? " ";
  }
}
