import 'package:e_con/src/data/models/profile/major_data.dart';
import 'package:equatable/equatable.dart';

class LectureData extends Equatable {
  LectureData({this.id, this.idNumber, this.name, this.major});

  final int? id;
  final String? idNumber;
  final String? name;
  final MajorData? major;

  factory LectureData.fromJson(Map<String, dynamic> json) => LectureData(
        id: json["id"],
        idNumber: json["idNumber"],
        name: json["name"],
        major: MajorData.fromJson(json['major']),
      );

  @override
  List<Object?> get props => [
        id,
        idNumber,
        name,
      ];
}
