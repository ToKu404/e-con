import 'package:equatable/equatable.dart';

class CourseStudentData extends Equatable {
  CourseStudentData({
    this.id,
    this.gender,
    this.name,
  });

  final String? id;
  final String? gender;
  final String? name;

  factory CourseStudentData.fromJson(Map<String, dynamic> json) =>
      CourseStudentData(
        id: json['idNumber'],
        gender: json['gender'],
        name: json['name'],
      );

  @override
  List<Object?> get props => [id, gender, name];
}
