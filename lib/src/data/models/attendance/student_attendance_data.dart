import 'package:e_con/src/data/models/attendance/attendance_data.dart';
import 'package:e_con/src/data/models/attendance/student_data_attendance_data.dart';
import 'package:equatable/equatable.dart';

class StudentAttendanceData extends Equatable {
  StudentAttendanceData({this.id, this.attendances, this.idNumber, this.name});

  final int? id;
  final String? idNumber;
  final String? name;
  final List<StudentDataAttendanceData>? attendances;

  factory StudentAttendanceData.fromJson(Map<String, dynamic> json) {
    Iterable data = json['attendances'] as List;
    return StudentAttendanceData(
      idNumber: json['idNumber'],
      id: json['id'],
      attendances: List<StudentDataAttendanceData>.from(
        data.map(
          (e) => StudentDataAttendanceData.fromJson(e),
        ),
      ),
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [id, idNumber, attendances, name];
}
