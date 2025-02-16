import 'package:flutter/material.dart';
import 'package:gate_log/src/main.dart';
import 'package:onestop_kit/onestop_kit.dart';

void showSnackBar(String message) {
  gatelogRootScaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(message, style: OnestopFonts.w500),
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
    ),
  );
}