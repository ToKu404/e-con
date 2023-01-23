import 'package:e_con/src/data/models/final_exam/fe_examiner.dart';
import 'package:e_con/src/data/models/final_exam/fe_student.dart';
import 'package:e_con/src/data/models/final_exam/fe_supervisor.dart';
import 'package:equatable/equatable.dart';

class FinalExamData extends Equatable {
  final int? id;
  final String? title;
  final FeStudent? student;
  final List<FeExaminer>? listExaminer;
  final List<FeSupervisor>? listSupervisor;

  FinalExamData(
      {this.id,
      this.student,
      this.title,
      this.listExaminer,
      this.listSupervisor});

  factory FinalExamData.fromJson(Map<String, dynamic> json) {
    Iterable examinerList = [];
    if (json['penguji'] != null) {
      examinerList = json['penguji'] as List;
    }
    Iterable supervisorList = [];
    if (json['pembimbing'] != null) {
      supervisorList = json['pembimbing'] as List;
    }
    return FinalExamData(
      id: json['taId'],
      student: FeStudent.fromJson(json['mahasiswa']),
      listExaminer: json['penguji'] != null
          ? List<FeExaminer>.from(
              examinerList.map(
                (e) => FeExaminer.fromJson(e),
              ),
            )
          : null,
      listSupervisor: json['pembimbing'] != null
          ? List<FeSupervisor>.from(
              supervisorList.map(
                (e) => FeSupervisor.fromJson(e),
              ),
            )
          : null,
      title: json['taJudul'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        student,
      ];
}
