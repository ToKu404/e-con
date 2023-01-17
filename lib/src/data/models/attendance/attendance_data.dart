import 'package:e_con/src/data/models/attendance/attendance_type.dart';
import 'package:e_con/src/data/models/profile/student_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:equatable/equatable.dart';

class AttendanceData extends Equatable {
  AttendanceData({this.meetingData, this.studentData, this.attendanceType});

  final MeetingData? meetingData;
  final StudentData? studentData;
  final AttendanceType? attendanceType;

  factory AttendanceData.fromJson(Map<String, dynamic> json) => AttendanceData(
        meetingData: MeetingData.fromJson(json['meeting']),
        studentData: StudentData.fromJson(json['student']),
        attendanceType: AttendanceType.fromJson(json['attendanceType']),
      );

  @override
  List<Object?> get props => [meetingData, studentData];
}
