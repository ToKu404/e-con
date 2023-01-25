import 'package:e_con/src/data/models/final_exam/fe_examiner.dart';
import 'package:e_con/src/data/models/final_exam/fe_student.dart';
import 'package:e_con/src/data/models/final_exam/fe_supervisor.dart';
import 'package:equatable/equatable.dart';

class FeFinalExam extends Equatable {
  final int? id;
  final List<FeExaminer>? listExaminer;
  final List<FeSupervisor>? listSupervisor;

  FeFinalExam({this.id, this.listExaminer, this.listSupervisor});

  factory FeFinalExam.fromJson(Map<String, dynamic> json) {
    Iterable examinerList = [];
    if (json['penguji'] != null) {
      examinerList = json['penguji'] as List;
    }
    Iterable supervisorList = [];
    if (json['pembimbing'] != null) {
      supervisorList = json['pembimbing'] as List;
    }
    return FeFinalExam(
      id: json['taId'],
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
    );
  }

  @override
  List<Object?> get props => [id, listExaminer, listSupervisor];
}
