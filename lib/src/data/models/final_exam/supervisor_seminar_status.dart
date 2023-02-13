import 'package:equatable/equatable.dart';

class SupervisorSeminarStatus extends Equatable {
  final String? proposedStatus;

  SupervisorSeminarStatus({
    this.proposedStatus,
  });

  // 1 diterima
  factory SupervisorSeminarStatus.fromJson(Map<String, dynamic> json) {
    return SupervisorSeminarStatus(
      proposedStatus: json['statusPermohonan'],
    );
  }

  @override
  List<Object?> get props => [
        proposedStatus,
      ];
}
