import 'package:e_con/src/data/models/final_exam/fe_final_exam.dart';
import 'package:e_con/src/data/models/final_exam/final_exam_data.dart';
import 'package:equatable/equatable.dart';

class FeSeminar extends Equatable {
  final int? seminarId;
  final int? seminarLastExamId;
  final DateTime? date;
  final String? startTime;
  final String? invitationFiles;
  final String? availabilityFiles;
  final String? endTime;
  final String? place;
  final String? link;
  final String? examType;
  final FeFinalExam? finalExamData;

  FeSeminar(
      {this.date,
      this.endTime,
      this.finalExamData,
      this.link,
      this.place,
      this.examType,
      this.seminarId,
      this.seminarLastExamId,
      this.startTime,
      this.availabilityFiles,
      this.invitationFiles});

  factory FeSeminar.fromJson(Map<String, dynamic> json) {
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
      seminarLastExamId: json['smrTaId'],
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
      ];
}
