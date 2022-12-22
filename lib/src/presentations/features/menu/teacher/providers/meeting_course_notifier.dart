import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_list_meeting.dart';
import 'package:flutter/material.dart';

class MeetingCourseNotifier extends ChangeNotifier {
  final GetListMeeting getListMeetingUsecase;

  MeetingCourseNotifier({
    required this.getListMeetingUsecase,
  });

  String _error = '';
  String get error => _error;

  RequestState _state = RequestState.init;
  RequestState get state => _state;

  List<MeetingData>? _listMeeting;
  List<MeetingData>? get listMeeting => _listMeeting;

  Future<void> getListMeeting({required int classId}) async {
    _state = RequestState.loading;
    notifyListeners();
    final result = await getListMeetingUsecase.execute(classId);

    result.fold((l) {
      _error = l.message;
      _state = RequestState.error;
    }, (r) {
      _listMeeting = r;
      _state = RequestState.success;
    });
    notifyListeners();
  }
}
