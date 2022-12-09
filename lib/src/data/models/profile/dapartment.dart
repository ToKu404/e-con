import 'package:equatable/equatable.dart';

class Department extends Equatable {
  final String? departmentName;

  Department({this.departmentName});

  factory Department.fromJson(Map<String, dynamic> json) => Department(
        departmentName: json["dprtNama"],
      );

  @override
  List<Object?> get props => [departmentName];
}
