import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/statistic_data.dart';
import 'package:equatable/equatable.dart';

class MeetingData extends Equatable {
  MeetingData({
    this.date,
    required this.id,
    this.topics,
    this.validationCodeExpiredDate,
    this.clazzData,
    this.listAttendanceType,
  });

  final DateTime? date;
  final int id;
  DateTime? validationCodeExpiredDate;
  final String? topics;
  int? meetingNumber;
  ClazzData? clazzData;
  List<StatisticData>? listAttendanceType;

  factory MeetingData.fromJson(Map<String, dynamic> json) {
    Iterable data = [];
    if (json['listOfAttendanceTypeScore'] != null) {
      data = json['listOfAttendanceTypeScore'] as List;
    }
    return MeetingData(
      date: DateTime.parse(json['date']),
      id: json['id'],
      topics: json['topics'],
      validationCodeExpiredDate: json['validationCodeExpireDateTime'] != null
          ? DateTime.parse(json['validationCodeExpireDateTime'])
          : null,
      clazzData: ClazzData.fromJson(json['clazz']),
      listAttendanceType: List<StatisticData>.from(
        data.map(
          (e) => StatisticData.fromJson(e),
        ),
      ),
    );
  }

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
