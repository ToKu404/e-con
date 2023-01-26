import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/profile/notification.dart';
import 'package:e_con/src/domain/usecases/profile_usecases/get_notifications.dart';
import 'package:flutter/material.dart';

class UserNotifNotifier extends ChangeNotifier {
  final GetNotifications getNotifications;

  UserNotifNotifier({
    required this.getNotifications,
  });

  String _error = '';
  String get error => _error;

  RequestState _state = RequestState.init;
  RequestState get state => _state;

  List<NotificationModel> _listNotif = [];
  List<NotificationModel> get listNotif => _listNotif;

  Future<void> fetchNotifications() async {
    _listNotif.clear();
    _state = RequestState.loading;
    notifyListeners();
    final result = await getNotifications.execute();

    result.fold((l) {
      _error = l.message;
      _state = RequestState.error;
    }, (r) {
      _listNotif = r;
      _state = RequestState.success;
    });
    notifyListeners();
  }
}
