import 'package:equatable/equatable.dart';

class SkPembimbing extends Equatable {
  final int? statusSkb;

  SkPembimbing({
    this.statusSkb,
  });

  // 1 diterima
  factory SkPembimbing.fromJson(Map<String, dynamic> json) {
    return SkPembimbing(
      statusSkb: json['skbStatus'],
    );
  }

  @override
  List<Object?> get props => [
        statusSkb,
      ];
}
