import 'package:flutter/widgets.dart';


class FinalExamObject {
  final String title;
  final String? message;
  final String status;
  final Color color;
  final VoidCallback? onclick;

  FinalExamObject(
      {required this.title,
      this.message,
      required this.status,
      this.onclick,
      required this.color});
}

final Map<String, String> seminarType = {
  'Seminar_Proposal': 'Seminar Proposal',
  'Seminar_Hasil': 'Seminar Hasil',
  'Ujian_Skripsi': 'Ujian Skripsi',
};

Map<String, String> feStatus = {
  'Belum_Diproses': 'Belum Diproses',
  'Sedang_Diproses': 'Sedang Diproses',
  'Diterima': 'Diterima',
  'Ditolak': 'Ditolak',
};
