import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:e_con/src/domain/usecases/activity_usecases/get_all_meeting_by_date.dart';
import 'package:flutter/material.dart';

class StudentActivityNotifier extends ChangeNotifier {
  final GetAllMeetingByDate getAllMeetingByDate;

  StudentActivityNotifier({
    required this.getAllMeetingByDate,
  });

  String _error = '';
  String get error => _error;

  RequestState _state = RequestState.init;
  RequestState get state => _state;

  List<MeetingData> _listMeetingData = [];
  List<MeetingData> get listMeetingData => _listMeetingData;

  Future<void> fetchAllMeetingByDate({DateTime? date}) async {
    _listMeetingData.clear();
    _state = RequestState.loading;
    notifyListeners();
    final result = await getAllMeetingByDate.execute(dateTime: date);

    result.fold((l) {
      _error = l.message;
      _state = RequestState.error;
    }, (r) {
      _listMeetingData = r ?? [];
      _state = RequestState.success;
    });
    notifyListeners();
  }
}
