import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/user/user_credential.dart';
import 'package:e_con/src/domain/usecases/user_usecases/get_credential.dart';
import 'package:e_con/src/domain/usecases/user_usecases/get_user.dart';
import 'package:flutter/widgets.dart';

class GetUserNotifier extends ChangeNotifier {
  final GetUser getUserUsecase;
  final GetCredential getCredentialUsecase;

  GetUserNotifier(
      {required this.getUserUsecase, required this.getCredentialUsecase}) {
    getUser();
  }

  RequestState _state = RequestState.init;
  RequestState get state => _state;

  UserCredential? _user;
  UserCredential? get user => _user;

  String _error = '';
  String get error => _error;

  void getUser() async {
    final result = await getUserUsecase.execute();

    result.fold(
      (failure) {
        _error = failure.message;
        _user = null;
        _state = RequestState.error;
      },
      (user) {
        _user = user;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }

  Map<String, String> _credential = {};
  Map<String, String> get credential => _credential;

  void getCredential() async {
    final result = await getCredentialUsecase.execute();

    result.fold(
      (failure) {
        _error = failure.message;
        _user = null;
        _state = RequestState.error;
      },
      (credential) {
        _credential = credential;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }
}
