import 'package:equatable/equatable.dart';

class FeProposedThesis extends Equatable {
  final int? id;
  final String? title;
  final String? krs;
  final String? khs;
  final DateTime? dateIn;
  final String? proposalStatus;
  final String? krsKhsAcceptment;
  final String? skStatus;

  FeProposedThesis({
    this.id,
    this.title,
    this.krs,
    this.khs,
    this.dateIn,
    this.krsKhsAcceptment,
    this.proposalStatus,
    this.skStatus,
  });

  factory FeProposedThesis.fromJson(Map<String, dynamic> json) {
    return FeProposedThesis(
        id: json['taId'],
        title: json['taJudul'],
        dateIn: DateTime.parse(json['tanggalMasuk']),
        khs: json['taKHS'],
        krs: json['taKRS'],
        krsKhsAcceptment: json['taKRSKHSStatus'],
        proposalStatus: json['statusPermohonan'],
        skStatus: json['taStatusSk']);
  }

  @override
  List<Object?> get props => [
        id,
        title,
        krs,
        khs,
        dateIn,
        krsKhsAcceptment,
        proposalStatus,
        skStatus,
      ];
}
