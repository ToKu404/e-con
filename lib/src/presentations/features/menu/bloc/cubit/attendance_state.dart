part of 'attendance_cubit.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class FetchAttendanceFailure extends AttendanceState {
  final String message;

  FetchAttendanceFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class FetchAttendanceSuccess extends AttendanceState {
  final List<AttendanceData> attendanceData;

  FetchAttendanceSuccess({required this.attendanceData});

  @override
  List<Object> get props => [attendanceData];
}
