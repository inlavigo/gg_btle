
import 'dart:async';

import 'package:flutter/services.dart';

class GgBtle {
  static const MethodChannel _channel = MethodChannel('gg_btle');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
