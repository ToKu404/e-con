import 'package:e_con/src/data/models/final_exam/fe_supervisor.dart';
import 'package:equatable/equatable.dart';

class SupervisorSeminarStatus extends Equatable {
  final String? proposedStatus;
  final FeSupervisor? supervisor;

  SupervisorSeminarStatus({
    this.proposedStatus,
    this.supervisor,
  });

  // 1 diterima
  factory SupervisorSeminarStatus.fromJson(Map<String, dynamic> json) {
    return SupervisorSeminarStatus(
      proposedStatus: json['statusPermohonan'],
      supervisor: FeSupervisor.fromJson(json['pembimbing']),
    );
  }

  @override
  List<Object?> get props => [
        proposedStatus,
      ];
}
