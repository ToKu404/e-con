import 'package:flutter/services.dart';

// ignore: avoid_classes_with_only_static_members
class QrCodeTools {
  static const MethodChannel _channel = MethodChannel('qr_code_tools');

  /// [filePath] is local file path
  static Future<String?> decodeFrom(String filePath) async {
    final String? data =
        await _channel.invokeMethod('decoder', {'file': filePath});
    return data;
  }
}
