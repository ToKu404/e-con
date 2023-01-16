import 'package:equatable/equatable.dart';

class AttendanceType extends Equatable {
  AttendanceType({this.id, this.name});

  final int? id;
  final String? name;

  factory AttendanceType.fromJson(Map<String, dynamic> json) => AttendanceType(
        id: json['id'],
        name: json['name'],
      );

  @override
  List<Object?> get props => [id, name];
}
