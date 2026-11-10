// PERSON 1: Kotlin (native Android) se baat karne wali service
import 'package:flutter/services.dart';

class NativeService {
  static const _channel = MethodChannel('meme_app/person1');

  static Future<void> showToast(String message) async {
    try {
      await _channel.invokeMethod('showToast', {'message': message});
    } on PlatformException catch (_) {
      // ignore
    } on MissingPluginException catch (_) {
      // sirf Android par chalta hai
    }
  }

  static Future<String> getDeviceInfo() async {
    try {
      final info = await _channel.invokeMethod<String>('getDeviceInfo');
      return info ?? 'Unknown';
    } on PlatformException catch (_) {
      return 'Unknown';
    } on MissingPluginException catch (_) {
      return 'Native code sirf Android par chalta hai';
    }
  }

  static Future<int> getBatteryLevel() async {
    try {
      final level = await _channel.invokeMethod<int>('getBatteryLevel');
      return level ?? -1;
    } on PlatformException catch (_) {
      return -1;
    } on MissingPluginException catch (_) {
      return -1;
    }
  }

  static Future<String> getScreenInfo() async {
    try {
      final info = await _channel.invokeMethod<String>('getScreenInfo');
      return info ?? 'Unknown';
    } on PlatformException catch (_) {
      return 'Unknown';
    } on MissingPluginException catch (_) {
      return 'Unknown';
    }
  }
}
