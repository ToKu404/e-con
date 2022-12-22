import 'package:equatable/equatable.dart';

class TimeData extends Equatable {
  final int? hour;
  final int? minute;

  TimeData({required this.hour, required this.minute});

  factory TimeData.fromJson(Map<String, dynamic> json) =>
      TimeData(hour: json['hour'], minute: json['minute']);

  @override
  List<Object?> get props => [hour, minute];
}
