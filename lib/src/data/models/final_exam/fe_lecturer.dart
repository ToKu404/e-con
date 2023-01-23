import 'package:equatable/equatable.dart';

class FeLecturer extends Equatable {
  final String? nip;
  final String? name;

  FeLecturer({this.nip, this.name});

  factory FeLecturer.fromJson(Map<String, dynamic> json) {
    return FeLecturer(
      name: json['dsnNama'],
      nip: json['dsnNip'],
    );
  }

  @override
  List<Object?> get props => [nip, name];
}
