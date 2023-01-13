import 'dart:async';

import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/create_new_meeting.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/delete_meeting.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_list_meeting.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_validation_code.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/update_meeting.dart';
import 'package:flutter/material.dart';

class MeetingCourseNotifier extends ChangeNotifier {
  final GetListMeeting getListMeetingUsecase;
  final CreateNewMeeting createNewMeetingUsecase;
  final DeleteMeeting deleteMeetingUsecase;
  final UpdateMeeting updateMeetingUsecase;
  final GetValidationCode getValidationCodeUsecase;

  MeetingCourseNotifier({
    required this.getListMeetingUsecase,
    required this.createNewMeetingUsecase,
    required this.updateMeetingUsecase,
    required this.deleteMeetingUsecase,
    required this.getValidationCodeUsecase,
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

  RequestState _createState = RequestState.init;
  RequestState get createState => _createState;

  Future<void> createNewMeeting({
    required int classId,
    required String topic,
    required DateTime meetingDate,
  }) async {
    _createState = RequestState.loading;
    notifyListeners();

    final res =
        await createNewMeetingUsecase.execute(classId, topic, meetingDate);
    res.fold((l) {
      _createState = RequestState.error;
    }, (r) {
      if (r) {
        _createState = RequestState.success;
      } else {
        _createState = RequestState.error;
      }
    });
    notifyListeners();
  }

  RequestState _deleteState = RequestState.init;
  RequestState get deleteState => _deleteState;

  Future<void> deleteMeeting({
    required int meetingId,
  }) async {
    _deleteState = RequestState.loading;
    final res = await deleteMeetingUsecase.execute(meetingId);
    res.fold((l) {
      _deleteState = RequestState.error;
    }, (r) {
      if (r) {
        _deleteState = RequestState.error;
      } else {
        _deleteState = RequestState.success;
      }
      ;
    });
    notifyListeners();
  }

  RequestState _editState = RequestState.init;
  RequestState get editState => _editState;

  Future<void> editMeeting({
    required int meetingId,
    int? classId,
    String? topic,
    DateTime? meetingDate,
  }) async {
    _editState = RequestState.loading;
    notifyListeners();

    final res = await updateMeetingUsecase.execute(
        meetingId: meetingId,
        classId: classId,
        meetingDate: meetingDate,
        topic: topic);
    res.fold((l) {
      _editState = RequestState.error;
    }, (r) {
      if (r) {
        _editState = RequestState.success;
      } else {
        _editState = RequestState.error;
      }
    });
    notifyListeners();
  }

  String? _validationCode;
  String? get validationCode => _validationCode;

  Future<void> getValidationCode({required int meetingId}) async {
    final res = await getValidationCodeUsecase.execute(meetingId: meetingId);
    res.fold((l) {
      _validationCode = null;
    }, (r) {
      _validationCode = r;
    });
    notifyListeners();
  }
}
