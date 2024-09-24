import 'package:flutter/services.dart';

class NativeService {
  static const MethodChannel _channel =
      MethodChannel('com.fpv.blocpitfall/channel');

  Future<String> getNativeData() async {
    try {
      final String result = await _channel.invokeMethod('getNativeData');
      return result;
    } on PlatformException catch (e) {
      return "Failed to get data: '${e.message}'";
    }
  }
}
