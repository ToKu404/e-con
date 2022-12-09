import 'package:e_con/src/data/models/profile/study_program.dart';
import 'package:equatable/equatable.dart';

class StudentData extends Equatable {
  StudentData({
    this.studentId,
    this.studentName,
    this.studentGender,
    this.studyProgram,
  });

  final String? studentId;
  final String? studentName;
  final String? studentGender;
  final StudyProgram? studyProgram;

  factory StudentData.fromJson(Map<String, dynamic> json) => StudentData(
        studentId: json["mhsNim"],
        studentName: json["mhsNama"],
        studentGender: json["mhsJk"],
        studyProgram: json["ref_prodi"] != null
            ? StudyProgram.fromJson(json["ref_prodi"])
            : null,
      );

  @override
  List<Object?> get props => [
        studentId,
        studentName,
        studentGender,
        studyProgram,
      ];
}
