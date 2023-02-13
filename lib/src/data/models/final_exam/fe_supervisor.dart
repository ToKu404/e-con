import 'package:e_con/src/data/models/final_exam/fe_lecturer.dart';
import 'package:equatable/equatable.dart';

class FeSupervisor extends Equatable {
  final String? supervisorPosition;
  final FeLecturer? lecturer;

  FeSupervisor({this.supervisorPosition, this.lecturer});

  factory FeSupervisor.fromJson(Map<String, dynamic> json) {
    return FeSupervisor(
      supervisorPosition: json['ref_posisipmb'],
      lecturer: FeLecturer.fromJson(json['dosen']),
      
    );
  }

  @override
  List<Object?> get props => [supervisorPosition, lecturer];
}
