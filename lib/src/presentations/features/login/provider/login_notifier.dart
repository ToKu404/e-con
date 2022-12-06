import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/user_credential.dart';
import 'package:e_con/src/domain/usecases/user_usecases/sign_in.dart';
import 'package:flutter/widgets.dart';

class LoginNotifier extends ChangeNotifier {
  final SignIn signInUsecase;

  LoginNotifier({
    required this.signInUsecase,
  });

  RequestState _state = RequestState.init;
  RequestState get state => _state;

  String _error = '';
  String get error => _error;

  UserCredential? _user;
  UserCredential? get user => _user;

  Future<void> signIn(String username, String password) async {
    _state = RequestState.loading;
    notifyListeners();
    final result = await signInUsecase.execute(username, password);

    result.fold((l) {
      _error = l.message;
      _state = RequestState.error;
    }, (r) {
      _user = r;
      _state = RequestState.success;
    });
    notifyListeners();
  }
}
