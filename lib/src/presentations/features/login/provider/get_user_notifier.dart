import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/user/user_credential.dart';
import 'package:e_con/src/domain/usecases/user_usecases/get_user.dart';
import 'package:flutter/widgets.dart';

class GetUserNotifier extends ChangeNotifier {
  final GetUser getUserUsecase;

  GetUserNotifier({required this.getUserUsecase}) {
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
}
