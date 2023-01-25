import 'package:equatable/equatable.dart';

class FeExam extends Equatable {
  final int? id;
  final String? validationDocStatus;
  final String? verificationDocStatus;
  final String? proposalStatus;
  final bool? statusTTD;
  final DateTime? skDate;

  FeExam({
    this.id,
    this.proposalStatus,
    this.skDate,
    this.statusTTD,
    this.validationDocStatus,
    this.verificationDocStatus,
  });

  factory FeExam.fromJson(Map<String, dynamic> json) {
    return FeExam(
      id: json['tugas_akhirTaId'],
      proposalStatus: json['statusPermohonan'],
      skDate:
          json['tanggalSK'] != null ? DateTime.parse(json['tanggalSK']) : null,
      statusTTD: json['statusTTD'],
      validationDocStatus: json['statusValidasiBerkas'],
      verificationDocStatus: json['statusVerifikasiBerkas'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        proposalStatus,
        skDate,
        statusTTD,
        validationDocStatus,
        verificationDocStatus,
      ];
}
