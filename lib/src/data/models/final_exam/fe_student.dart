import 'package:equatable/equatable.dart';

class FeStudent extends Equatable {
  final String? nim;
  final String? name;

  FeStudent({this.nim, this.name});

  factory FeStudent.fromJson(Map<String, dynamic> json) {
    return FeStudent(
      name: json['mhsNama'],
      nim: json['mhsNim'],
    );
  }

  @override
  List<Object?> get props => [nim, name];
}
