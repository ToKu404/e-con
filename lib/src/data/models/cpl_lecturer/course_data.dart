import 'package:equatable/equatable.dart';

class CourseData extends Equatable {
  final int? id;
  final String? courseName;
  final int? givenSemester;

  CourseData(
      {required this.courseName,
      required this.givenSemester,
      required this.id});

  factory CourseData.fromJson(Map<String, dynamic> json) => CourseData(
        id: json["id"],
        courseName: json['name'],
        givenSemester: json['givenSemester'],
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        courseName,
        givenSemester,
      ];
}
