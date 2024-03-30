import 'package:flutter/material.dart';
import 'package:khokha_entry/src/globals/my_fonts.dart';
import 'package:dio/dio.dart';

void showSnackBar(BuildContext context,String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: MyFonts.w500),
      duration: const Duration(seconds: 1),
    ),
  );
}

void showErrorSnackBar(BuildContext context,DioException err) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      (err.response != null)
          ? err.response!.data['message']
          : "Some error occurred. try again",
      style: MyFonts.w500,
    ),
    duration: const Duration(seconds: 5),
  ));
}
