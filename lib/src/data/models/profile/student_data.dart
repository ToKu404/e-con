import 'package:e_con/src/data/models/profile/major_data.dart';
import 'package:equatable/equatable.dart';

class StudentData extends Equatable {
  StudentData({
    this.id,
    this.nim,
    this.name,
    this.major,
  });

  final int? id;
  final String? nim;
  final String? name;
  final MajorData? major;

  factory StudentData.fromJson(Map<String, dynamic> json) => StudentData(
        nim: json['idNumber'],
        name: json['name'],
        id: json['id'],
        major: MajorData.fromJson(json['major']),
      );

  @override
  List<Object?> get props => [nim, name, id];
}
