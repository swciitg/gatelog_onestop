import 'package:gate_log/src/globals/endpoints.dart';
import 'package:gate_log/src/models/entry_details.dart';
import 'package:gate_log/src/utility/show_snackbar.dart';
import 'package:onestop_kit/onestop_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class APIService extends OneStopApi {
  APIService()
      : super(
          onestopBaseUrl: Endpoints.onestopBaseUrl,
          serverBaseUrl: Endpoints.gateLogServerUrl,
          onestopSecurityKey: Endpoints.onestopSecurityKey,
          onRefreshTokenExpired: () async {
            final prefs = await SharedPreferences.getInstance();
            await prefs.clear();
            showSnackBar("Your session has expired! Login again.");
          },
        );

  Future<String> getUserId() async {
    final res = await onestopDio.get('/user/getUserid');
    return res.data['userId'];
  }

  Future<List<EntryDetails>> getLogHistory(int pageNumber, int pageSize) async {
    print("${this.serverBaseUrl}${Endpoints.getAllLogs}");
    print("${serverDio.options.baseUrl}");
    final res = await serverDio.get(Endpoints.getAllLogs, queryParameters: {
      'page': pageNumber.toString(),
      'size': pageSize.toString()
    });
    List<EntryDetails> entriesPage = (res.data['history'] as List)
        .map((e) => EntryDetails.fromJson(e))
        .toList();
    return entriesPage;
  }
}
