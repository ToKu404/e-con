import 'package:e_con/src/data/models/attendance/attendance_type.dart';
import 'package:equatable/equatable.dart';

class StatisticData extends Equatable {
  final AttendanceType? attendance;
  final int? score;

  StatisticData({required this.score, required this.attendance});

  factory StatisticData.fromJson(Map<String, dynamic> json) => StatisticData(
      attendance: AttendanceType.fromJson(json['attendanceTypeDto']),
      score: json['score']);

  @override
  List<Object?> get props => [attendance, score];
}
