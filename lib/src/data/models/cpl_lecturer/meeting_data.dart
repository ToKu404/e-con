import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class MeetingData extends Equatable {
  MeetingData({
    this.date,
    required this.id,
    this.topics,
    this.validationCodeExpiredDate,
    this.clazzData,
  });

  final DateTime? date;
  final int id;
  DateTime? validationCodeExpiredDate;
  final String? topics;
  int? meetingNumber;
  ClazzData? clazzData;

  factory MeetingData.fromJson(Map<String, dynamic> json) => MeetingData(
        date: DateTime.parse(json['date']),
        id: json['id'],
        topics: json['topics'],
        validationCodeExpiredDate: json['validationCodeExpireDateTime'] != null
            ? DateTime.parse(json['validationCodeExpireDateTime'])
            : null,
        clazzData: ClazzData.fromJson(json['clazz']),
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
