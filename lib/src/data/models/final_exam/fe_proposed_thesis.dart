import 'package:e_con/src/data/models/final_exam/fe_examiner.dart';
import 'package:e_con/src/data/models/final_exam/fe_supervisor.dart';
import 'package:e_con/src/data/models/final_exam/sk_peguji.dart';
import 'package:e_con/src/data/models/final_exam/sk_pembimbing.dart';
import 'package:equatable/equatable.dart';

class FeProposedThesis extends Equatable {
  final int? id;
  final String? title;
  final String? krs;
  final String? khs;
  final DateTime? dateIn;
  final String? proposalStatus;
  final String? krsKhsAcceptment;
  final List<SkPenguji>? examinerSk;
  final List<SkPembimbing>? supervisorSk;
  final List<FeExaminer>? listExaminer;
  final List<FeSupervisor>? listSupervisor;

  FeProposedThesis({
    this.id,
    this.title,
    this.krs,
    this.khs,
    this.dateIn,
    this.krsKhsAcceptment,
    this.proposalStatus,
    this.listExaminer,
    this.listSupervisor,
    this.examinerSk,
    this.supervisorSk,
  });

  factory FeProposedThesis.fromJson(Map<String, dynamic> json) {
    Iterable examinerList = [];
    if (json['penguji'] != null) {
      examinerList = json['penguji'] as List;
    }
    Iterable supervisorList = [];
    if (json['pembimbing'] != null) {
      supervisorList = json['pembimbing'] as List;
    }
    Iterable supervisorSkList = [];
    if (json['sk_pembimbing'] != null) {
      supervisorSkList = json['sk_pembimbing'] as List;
    }

    Iterable examinerSkList = [];
    if (json['sk_penguji'] != null) {
      examinerSkList = json['sk_penguji'] as List;
    }
    return FeProposedThesis(
      id: json['taId'],
      title: json['taJudul'],
      dateIn: DateTime.parse(json['tanggalMasuk']),
      khs: json['taKHS'],
      krs: json['taKRS'],
      krsKhsAcceptment: json['taKRSKHSStatus'],
      proposalStatus: json['statusPermohonan'],
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
      examinerSk: json['sk_penguji'] != null
          ? List<SkPenguji>.from(
              examinerSkList.map(
                (e) => SkPenguji.fromJson(e),
              ),
            )
          : null,
      supervisorSk: json['sk_pembimbing'] != null
          ? List<SkPembimbing>.from(
              supervisorSkList.map(
                (e) => SkPembimbing.fromJson(e),
              ),
            )
          : null,
    );
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
      ];
}
