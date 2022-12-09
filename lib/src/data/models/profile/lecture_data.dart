import 'package:equatable/equatable.dart';

class LectureData extends Equatable {
  LectureData({
    this.lectureNIP,
    this.lectureName,
    this.lectureNIDN,
    this.lecturePhoto,
  });

  final String? lectureNIP;
  final String? lectureName;
  final String? lectureNIDN;
  final String? lecturePhoto;

  factory LectureData.fromJson(Map<String, dynamic> json) => LectureData(
        lectureNIP: json["dsnNip"],
        lectureName: json["dsnNama"],
        lectureNIDN: json["dsnNIDN"],
        lecturePhoto: json["dsnFoto"],
      );

  @override
  List<Object?> get props => [
        lectureNIP,
        lectureName,
        lectureNIDN,
        lecturePhoto,
      ];
}
