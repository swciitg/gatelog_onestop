import 'package:dio/src/dio.dart';
import 'package:khokha_entry/src/globals/endpoints.dart';
import 'package:onestop_kit/onestop_kit.dart';

class Apis extends OneStopApi{
  Apis(): super(onestopBaseUrl: Endpoints.onestopBaseUrl, onestopSecurityKey: Endpoints.onestopSecurityKey);

  @override
  Dio get onestopDio => super.onestopDio;

  Future<String> getUserId()async{
    try {
      final res = await onestopDio.get("/user/userId");
      print("USER ID:");
      print(res.data);
      return '';
    } catch (e) {
      rethrow;
    }
  }
}