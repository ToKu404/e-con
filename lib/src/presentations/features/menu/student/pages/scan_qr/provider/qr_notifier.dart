import 'package:e_con/core/utils/request_state.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:e_con/src/domain/usecases/cpl_lecturer_usecases/get_meeting_data.dart';
import 'package:flutter/widgets.dart';

class QrNotifier extends ChangeNotifier {
  final GetMeetingData getMeetingDataUsecase;

  QrNotifier({
    required this.getMeetingDataUsecase,
  });

  String? _qrData;
  String? get qrData => _qrData;

  QrResult? _qrResult;
  QrResult? get qrResult => _qrResult;

  RequestState _qrRequestState = RequestState.init;
  RequestState get qrRequestState => _qrRequestState;

  void resetQrCode() {
    _qrResult = null;
    _qrData = null;
    _qrRequestState = RequestState.init;
    notifyListeners();
  }

  void setQrCode(String qr) async {
    _qrData = qr;
    _qrRequestState = RequestState.loading;
    notifyListeners();

    int meetingId = int.parse(qr.split(' ')[0]);
    String? validationCode = qr.split(' ')[1];
    MeetingData? meetingData;

    final res = await getMeetingDataUsecase.execute(meetingId: meetingId);
    res.fold((l) {
      _qrRequestState = RequestState.error;
    }, (r) {
      meetingData = r;
      _qrRequestState = RequestState.success;
    });

    if (meetingData != null && validationCode.isNotEmpty) {
      _qrResult =
          QrResult(meetingData: meetingData!, validationCode: validationCode);
    }
    notifyListeners();
  }
}

class QrResult {
  final MeetingData meetingData;
  final String validationCode;

  QrResult({
    required this.meetingData,
    required this.validationCode,
  });
}
