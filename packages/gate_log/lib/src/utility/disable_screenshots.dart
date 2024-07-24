import 'package:flutter/services.dart';

void disableScreenshots(bool disable) {
  const platform = MethodChannel('com.example.app/screenshot');
  platform.invokeMethod('preventScreenshots', disable);
}
