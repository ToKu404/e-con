import 'package:equatable/equatable.dart';

class CourseData extends Equatable {
  CourseData({
    this.classId,
    this.className,
    this.courseId,
    this.courseName,
    this.semesterId,
  });

  final int? classId;
  final String? className;
  final int? courseId;
  final String? courseName;
  final int? semesterId;

  factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
        classId: json["classId"],
        className: json["className"],
        courseId: json["courseId"],
        courseName: json["courseName"],
        semesterId: json["semesterId"],
      );

  @override
  List<Object?> get props => [
        classId,
        className,
        courseId,
        courseName,
        semesterId,
      ];
}
