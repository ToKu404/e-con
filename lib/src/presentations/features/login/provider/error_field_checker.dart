import 'package:flutter/widgets.dart';

class ErrorFieldChecker extends ChangeNotifier {
  bool _isPasswordError = false;
  bool _isUsernameError = false;

  bool get isPasswordError => _isPasswordError;
  bool get isUsernameError => _isUsernameError;

  void startChecker(String username, String password) {
    if (username.isEmpty) {
      _isUsernameError = true;
    } else {
      _isUsernameError = false;
    }

    if (password.isEmpty) {
      _isPasswordError = true;
    } else {
      _isPasswordError = false;
    }

    notifyListeners();
  }

  void usernameActive() {
    _isUsernameError = false;
    notifyListeners();
  }

  void passwordActive() {
    _isPasswordError = false;
    notifyListeners();
  }
}
