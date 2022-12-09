import 'package:flutter/widgets.dart';

class QrNotifier extends ChangeNotifier {
  String _qrCode = '';

  String get qrCode => _qrCode;

  void resetQrCode() {
    _qrCode = '';
    notifyListeners();
  }

  void setQrCode(String qr) {
    _qrCode = qr;
    notifyListeners();
  }
}
