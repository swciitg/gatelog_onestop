import 'package:dio/dio.dart';
import 'package:khokha_entry/src/globals/endpoints.dart';
import 'package:khokha_entry/src/models/api_model.dart';
import 'package:onestop_kit/onestop_kit.dart';
import 'package:khokha_entry/src/utility/show_snackbar.dart';
import 'package:khokha_entry/src/models/entry_qr_model.dart';

class APIService {
  final dio = Dio(BaseOptions(
      baseUrl: Endpoints.khokhaWebSocketUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      headers: Endpoints.getHeader()));

  APIService() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          print("THIS IS TOKEN");
          print(await AuthUserHelpers.getAccessToken());
          print(options.path);
          print(options.headers);
          options.headers["Authorization"] =
              "Bearer ${await AuthUserHelpers.getAccessToken()}";
              print(options.headers);
          handler.next(options);
        },
        onError: (error, handler) async {
          print("A dio Error has occured and been caught");
          print(error);
          showSnackBar("Some error occurred. try again");
          var response = error.response;
          if (response != null && response.statusCode == 401) {
            if ((await AuthUserHelpers.getAccessToken()).isEmpty) {
              showSnackBar("Login to continue!!");
            } else {
              print(response.requestOptions.path);
              bool couldRegenerate = await regenerateAccessToken();
              // ignore: use_build_context_synchronously
              if (couldRegenerate) {
                print("COULD REGENRATE TOKEN");
                // retry
                return handler.resolve(await retryRequest(response));
              } else {
                showSnackBar("Your session has expired!! Login again.");
              }
            }
          } else if (response != null && response.statusCode == 403) {
            showSnackBar("Access not allowed in guest mode");
          } else if (response != null && response.statusCode == 400) {
            showSnackBar(response.data["message"]);
          }
          // admin user with expired tokens
          return handler.next(error);
        },
      ),
    );
  }
  Future<Response<dynamic>> retryRequest(Response response) async {
    RequestOptions requestOptions = response.requestOptions;
    response.requestOptions.headers[BackendHelper.authorization] =
        "Bearer ${await AuthUserHelpers.getAccessToken()}";
    final options =
        Options(method: requestOptions.method, headers: requestOptions.headers);
    Dio retryDio = Dio(BaseOptions(
        baseUrl: Endpoints.khokhaWebSocketUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 5),
        headers: {'Security-Key': Endpoints.onestopSecurityKey}));
    if (requestOptions.method == "GET") {
      return retryDio.request(requestOptions.path,
          queryParameters: requestOptions.queryParameters, options: options);
    } else {
      return retryDio.request(requestOptions.path,
          queryParameters: requestOptions.queryParameters,
          data: requestOptions.data,
          options: options);
    }
  }

  Future<bool> regenerateAccessToken() async {
    String refreshToken = await AuthUserHelpers.getRefreshToken();
    try {
      Dio regenDio = Dio(BaseOptions(
          baseUrl: Endpoints.khokhaWebSocketUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5)));
      Response<Map<String, dynamic>> resp =
          await regenDio.post("/user/accesstoken",
              options: Options(headers: {
                'Security-Key': Endpoints.onestopSecurityKey,
                "authorization": "Bearer $refreshToken"
              }));
      var data = resp.data!;
      print("REGENRATED ACCESS TOKEN");
      await AuthUserHelpers.setAccessToken(data[BackendHelper.accesstoken]);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<List<ApiModel>> pageEntries(int pageNumber, int pageSize) async {
    final queryParameters = {
      'page': pageNumber.toString(),
      'size': pageSize.toString()
    };
    var response = await dio.get(
        'https://swc.iitg.ac.in/test/khokhaEntry/api/v1/history',
        queryParameters: queryParameters);
    var json = response.data;
    print("THIS IS THE RESPONSE");
    print(json);
    List<ApiModel> EntriesPage = (json['history'] as List<dynamic>)
        .map((e) => ApiModel.fromJson(e))
        .toList();
    await Future.delayed(const Duration(milliseconds: 300), () => null);
    return EntriesPage;
  }
}
