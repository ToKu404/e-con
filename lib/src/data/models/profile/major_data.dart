import 'package:e_con/src/data/models/profile/dapartment.dart';
import 'package:equatable/equatable.dart';

class MajorData extends Equatable {
  MajorData({this.id, this.degree, this.name, this.departmentData});

  final int? id;
  final String? degree;
  final String? name;
  final DepartmentData? departmentData;

  factory MajorData.fromJson(Map<String, dynamic> json) => MajorData(
        id: json["id"],
        degree: json["degree"],
        name: json["name"],
        departmentData: DepartmentData.fromJson(json['department']),
      );

  @override
  List<Object?> get props => [
        id,
        degree,
        name,
        departmentData,
      ];
}
