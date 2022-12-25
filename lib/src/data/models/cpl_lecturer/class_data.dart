import 'package:e_con/src/data/models/cpl_lecturer/course_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/semester_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/time_data.dart';
import 'package:equatable/equatable.dart';

class ClazzData extends Equatable {
  ClazzData({
    this.id,
    this.name,
    this.startTime,
    this.endTime,
    this.courseData,
    this.semesterData,
  });

  final int? id;
  final String? name;
  final String? startTime;
  final String? endTime;
  final SemesterData? semesterData;
  final CourseData? courseData;

  factory ClazzData.fromJson(Map<String, dynamic> json) => ClazzData(
        id: json["id"],
        name: json["name"],
        semesterData: SemesterData.fromJson(json['semester']),
        courseData: CourseData.fromJson(json['course']),
        startTime: json['startTime'],
        endTime: json['endTime'],
      );

  @override
  List<Object?> get props => [
        id,
        name,
        startTime,
        endTime,
        courseData,
      ];
}
