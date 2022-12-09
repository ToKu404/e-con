import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/user_credential.dart';
import 'package:e_con/src/domain/usecases/user_usecases/log_out.dart';
import 'package:e_con/src/domain/usecases/user_usecases/sign_in.dart';
import 'package:flutter/widgets.dart';

class AuthNotifier extends ChangeNotifier {
  final LogOut logOutUsecase;
  final SignIn signInUsecase;

  AuthNotifier({required this.logOutUsecase, required this.signInUsecase}) {}

  String _error = '';
  String get error => _error;

  // LogOut Attribute and Function
  RequestState _logOutState = RequestState.init;
  RequestState get logOutState => _logOutState;

  Future<void> logOut() async {
    final result = await logOutUsecase.execute();

    result.fold(
      (failure) {
        _error = failure.message;
        _logOutState = RequestState.error;
      },
      (user) {
        _logOutState = RequestState.success;
      },
    );

    notifyListeners();
  }

  // Login Attribute and Function
  RequestState _loginState = RequestState.init;
  RequestState get loginState => _loginState;

  UserCredential? _user;
  UserCredential? get user => _user;
  Future<void> signIn(String username, String password) async {
    _loginState = RequestState.loading;
    notifyListeners();
    final result = await signInUsecase.execute(username, password);

    result.fold((l) {
      _error = l.message;
      _loginState = RequestState.error;
    }, (r) {
      _user = r;
      _loginState = RequestState.success;
    });
    notifyListeners();
  }
}
