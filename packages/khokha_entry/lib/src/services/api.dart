import 'package:dio/dio.dart';
import 'package:khokha_entry/src/globals/endpoints.dart';
import 'package:khokha_entry/src/models/entry_details.dart';
import 'package:onestop_kit/onestop_kit.dart';
import 'package:khokha_entry/src/utility/show_snackbar.dart';
import 'package:khokha_entry/src/models/entry_qr_model.dart';

class APIService extends OneStopApi {
  APIService(
      {required super.onestopBaseUrl, required super.onestopSecurityKey});

  Future<List<EntryDetails>> getLogHistory(int pageNumber, int pageSize) async {
    final queryParameters = {
      'page': pageNumber.toString(),
      'size': pageSize.toString()
    };
    var response = await onestopDio.get(
        'https://swc.iitg.ac.in/test/khokhaEntry/api/v1/history',
        queryParameters: queryParameters);
    var json = response.data;
    print("THIS IS THE RESPONSE");
    print(json);
    List<EntryDetails> EntriesPage = (json['history'] as List<dynamic>)
        .map((e) => EntryDetails.fromJson(e))
        .toList();
    await Future.delayed(const Duration(milliseconds: 300), () => null);
    return EntriesPage;
  }
}
