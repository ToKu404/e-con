import 'package:equatable/equatable.dart';

class SkPenguji extends Equatable {
  final String? statusSkp;

  SkPenguji({
    this.statusSkp,
  });

  // 1 diterima
  factory SkPenguji.fromJson(Map<String, dynamic> json) {
    return SkPenguji(
      statusSkp: json['skp_status'],
    );
  }

  @override
  List<Object?> get props => [
        statusSkp,
      ];
}
