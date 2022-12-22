import 'package:equatable/equatable.dart';

class SemesterData extends Equatable {
  final bool? active;
  final String? name;

  SemesterData({required this.active, required this.name});

  factory SemesterData.fromJson(Map<String, dynamic> json) => SemesterData(
        active: json['active'],
        name: json['name'],
      );

  @override
  // TODO: implement props
  List<Object?> get props => [active, name];
}
