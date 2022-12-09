import 'package:equatable/equatable.dart';

class StudyProgram extends Equatable {
  StudyProgram({
    this.name,
    this.degree,
  });

  final String? name;
  final String? degree;

  factory StudyProgram.fromJson(Map<String, dynamic> json) => StudyProgram(
        name: json["prdNama"],
        degree: json["jenjang"],
      );

  @override
  List<Object?> get props => [name, degree];
}
