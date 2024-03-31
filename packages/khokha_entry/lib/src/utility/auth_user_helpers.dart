import 'package:khokha_entry/src/utility/backend_helpers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthUserHelpers {
  static Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(BackendHelper.accesstoken) ?? " ";
  }
}
