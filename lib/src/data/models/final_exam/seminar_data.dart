import 'package:e_con/src/data/models/final_exam/final_exam_data.dart';
import 'package:equatable/equatable.dart';

class SeminarData extends Equatable {
  final int? seminarId;
  final int? seminarLastExamId;
  final DateTime? date;
  final String? startTime;
  final String? endTime;
  final String? place;
  final String? link;
  final String? examType;
  final FinalExamData? finalExamData;

  SeminarData({
    this.date,
    this.endTime,
    this.finalExamData,
    this.link,
    this.place,
    this.examType,
    this.seminarId,
    this.seminarLastExamId,
    this.startTime,
  });

  factory SeminarData.fromJson(Map<String, dynamic> json) {
    return SeminarData(
      date: json['smrTglSeminar'] != null
          ? DateTime.parse(json['smrTglSeminar'])
          : null,
      startTime: json['smrJamMulai'],
      endTime: json['smrJamSelesai'],
      link: json['smrLink'],
      place: json['smrTempat'],
      examType: json['ref_jenisujian'],
      finalExamData: FinalExamData.fromJson(json['tugas_akhir']),
      seminarId: json['smrId'],
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
