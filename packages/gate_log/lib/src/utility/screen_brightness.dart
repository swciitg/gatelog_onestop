import 'dart:developer';

import 'package:screen_brightness/screen_brightness.dart';

Future<void> setApplicationBrightness(double brightness) async {
  try {
    await ScreenBrightness.instance.setApplicationScreenBrightness(brightness);
  } catch (e) {
    log(e.toString());
    throw 'Failed to set application brightness';
  }
}

Future<void> resetApplicationBrightness() async {
  try {
    await ScreenBrightness.instance.resetApplicationScreenBrightness();
  } catch (e) {
    log(e.toString());
    throw 'Failed to reset application brightness';
  }
}
