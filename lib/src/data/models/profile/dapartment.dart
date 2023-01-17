import 'package:equatable/equatable.dart';

class DepartmentData extends Equatable {
  final String? departmentName;

  DepartmentData({this.departmentName});

  factory DepartmentData.fromJson(Map<String, dynamic> json) => DepartmentData(
        departmentName: json["name"],
      );

  @override
  List<Object?> get props => [departmentName];
}
