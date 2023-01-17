import 'package:e_con/src/data/models/attendance/attendance_type.dart';
import 'package:e_con/src/data/models/attendance/meeting_attendance_data.dart';
import 'package:equatable/equatable.dart';

class StudentDataAttendanceData extends Equatable {
  StudentDataAttendanceData({this.meetingData, this.attendanceType, this.id});

  final MeetingAttendanceData? meetingData;
  final int? id;
  final AttendanceType? attendanceType;

  factory StudentDataAttendanceData.fromJson(Map<String, dynamic> json) =>
      StudentDataAttendanceData(
          meetingData: MeetingAttendanceData.fromJson(json['meeting']),
          attendanceType: AttendanceType.fromJson(json['attendanceType']),
          id: json['id']);

  @override
  List<Object?> get props => [meetingData, attendanceType, id];
}
