import 'package:equatable/equatable.dart';

class SkPenguji extends Equatable {
  final int? statusSkp;

  SkPenguji({
    this.statusSkp,
  });

  // 1 diterima
  factory SkPenguji.fromJson(Map<String, dynamic> json) {
    return SkPenguji(
      statusSkp: json['skpStatus'],
    );
  }

  @override
  List<Object?> get props => [
        statusSkp,
      ];
}
