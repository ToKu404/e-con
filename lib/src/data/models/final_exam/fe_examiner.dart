import 'package:e_con/src/data/models/final_exam/fe_lecturer.dart';
import 'package:equatable/equatable.dart';

class FeExaminer extends Equatable {
  final FeLecturer? lecturer;
  final int? order;

  FeExaminer({this.lecturer, this.order});

  factory FeExaminer.fromJson(Map<String, dynamic> json) {
    return FeExaminer(
      lecturer: FeLecturer.fromJson(json['dosen']),
      order: json['ujiUrutan'],
    );
  }

  @override
  List<Object?> get props => [lecturer];
}
