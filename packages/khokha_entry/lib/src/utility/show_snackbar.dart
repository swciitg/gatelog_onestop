import 'package:flutter/material.dart';
import 'package:khokha_entry/src/globals/my_fonts.dart';
import 'package:dio/dio.dart';
import 'package:khokha_entry/src/main.dart';

void showSnackBar(String message) {
  rootScaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(message, style: MyFonts.w500),
      duration: const Duration(seconds: 1),
    ),
  );
}

void showErrorSnackBar(DioException err) {
  rootScaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
    content: Text(
      (err.response != null)
          ? err.response!.data['message']
          : "Some error occurred. try again",
      style: MyFonts.w500,
    ),
    duration: const Duration(seconds: 5),
  ));
}
