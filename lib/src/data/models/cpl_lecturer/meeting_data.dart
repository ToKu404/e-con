import 'package:e_con/src/data/models/cpl_lecturer/semester_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/time_data.dart';
import 'package:equatable/equatable.dart';

class MeetingData extends Equatable {
  MeetingData({
    this.startTime,
    this.endTime,
    this.semester,
    this.date,
  });

  final TimeData? startTime;
  final TimeData? endTime;
  final DateTime? date;
  final SemesterData? semester;

  factory MeetingData.fromJson(Map<String, dynamic> json) => MeetingData(
      startTime: TimeData.fromJson(json['startTime']),
      endTime: TimeData.fromJson(json['endTime']),
      date: DateTime.parse(json['date']),
      semester: SemesterData.fromJson(json['semester']));

  @override
  List<Object?> get props => [
        startTime,
        endTime,
        date,
        semester,
      ];
}
