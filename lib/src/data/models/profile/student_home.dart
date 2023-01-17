import 'package:e_con/src/data/models/profile/student_data.dart';
import 'package:equatable/equatable.dart';

class StudentHome extends Equatable {
  StudentHome({
    this.profile,
  });

  final StudentData? profile;

  factory StudentHome.fromJson(Map<String, dynamic> json) =>
      StudentHome(profile: StudentData.fromJson(json['profile']));

  @override
  List<Object?> get props => [profile];
}
