import 'package:e_con/src/data/models/final_exam/fe_final_exam.dart';
import 'package:e_con/src/data/models/final_exam/supervisor_seminar_status.dart';
import 'package:equatable/equatable.dart';

class FeSeminar extends Equatable {
  final int? seminarId;
  final int? seminarLastExamId;
  final DateTime? date;
  final String? startTime;
  final String? invitationFiles;
  final String? availabilityFiles;
  final String? newsFiles;
  final String? valueStatementFiles;
  final String? endTime;
  final String? place;
  final String? link;
  final String? examType;
  final FeFinalExam? finalExamData;
  final List<SupervisorSeminarStatus>? supervisorSeminarStatus;

  FeSeminar({
    this.date,
    this.endTime,
    this.finalExamData,
    this.link,
    this.place,
    this.examType,
    this.seminarId,
    this.seminarLastExamId,
    this.startTime,
    this.availabilityFiles,
    this.invitationFiles,
    this.supervisorSeminarStatus,
    this.newsFiles,
    this.valueStatementFiles,
  });

  factory FeSeminar.fromJson(Map<String, dynamic> json) {
    Iterable supervisorSeminarStatusList = [];
    if (json['seminar_status_pembimbing'] != null) {
      supervisorSeminarStatusList = json['seminar_status_pembimbing'] as List;
    }
    return FeSeminar(
      date: json['smrTglSeminar'] != null
          ? DateTime.parse(json['smrTglSeminar'])
          : null,
      startTime: json['smrJamMulai'],
      endTime: json['smrJamSelesai'],
      link: json['smrLink'],
      place: json['smrTempat'],
      examType: json['ref_jenisujian'],
      finalExamData: FeFinalExam.fromJson(json['tugas_akhir']),
      seminarId: json['smrId'],
      availabilityFiles: json['smrFileKesediaan'],
      invitationFiles: json['smrFileUndangan'],
      newsFiles: json['smrFileBeritaAcara'],
      valueStatementFiles: json['smrFileKeteranganNilai'],
      seminarLastExamId: json['smrTaId'],
      supervisorSeminarStatus: json['seminar_status_pembimbing'] != null
          ? List<SupervisorSeminarStatus>.from(
              supervisorSeminarStatusList.map(
                (e) => SupervisorSeminarStatus.fromJson(e),
              ),
            )
          : null,
    );
  }

  @override
  List<Object?> get props => [
        date,
        endTime,
        finalExamData,
        link,
        place,
        examType,
        seminarId,
        seminarLastExamId,
        startTime,
        supervisorSeminarStatus,
      ];
}
