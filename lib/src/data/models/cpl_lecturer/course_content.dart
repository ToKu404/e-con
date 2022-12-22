import 'dart:convert';

import 'package:e_con/src/data/models/cpl_lecturer/course_data.dart';
import 'package:equatable/equatable.dart';

class CourseContent extends Equatable {
  CourseContent({
    this.listCourse,
  });

  final List<CourseData>? listCourse;

  factory CourseContent.fromJson(Map<String, dynamic> json) {
    Iterable data = json['content'] as List;
    return CourseContent(
      listCourse: List<CourseData>.from(
        data.map(
          (e) => CourseData.fromJson(e),
        ),
      ),
    );
  }

  @override
  List<Object?> get props => [listCourse];
}
