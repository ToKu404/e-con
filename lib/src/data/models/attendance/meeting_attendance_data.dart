import 'package:equatable/equatable.dart';

class MeetingAttendanceData extends Equatable {
  MeetingAttendanceData({
    this.date,
    required this.id,
    this.topics,
    this.validationCodeExpiredDate,
  });

  final DateTime? date;
  final int id;
  DateTime? validationCodeExpiredDate;
  final String? topics;
  int? meetingNumber;

  factory MeetingAttendanceData.fromJson(Map<String, dynamic> json) => MeetingAttendanceData(
        date: DateTime.parse(json['date']),
        id: json['id'],
        topics: json['topics'],
        validationCodeExpiredDate: json['validationCodeExpireDateTime'] != null
            ? DateTime.parse(json['validationCodeExpireDateTime'])
            : null,
      );

  set setMeetingNumber(int meetingNumber) {
    this.meetingNumber = meetingNumber;
  }

  @override
  List<Object?> get props => [
        date,
        id,
        topics,
      ];
}
