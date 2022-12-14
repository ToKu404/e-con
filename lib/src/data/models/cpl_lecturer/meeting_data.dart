import 'package:equatable/equatable.dart';

class MeetingData extends Equatable {
  MeetingData({
    this.date,
    required this.id,
    this.topics,
  });

  final DateTime? date;
  final int id;
  final String? topics;
  int? meetingNumber;

  factory MeetingData.fromJson(Map<String, dynamic> json) => MeetingData(
        date: DateTime.parse(json['date']),
        id: json['id'],
        topics: json['topics'],
      );

  set setMeetingNumber(int meetingNumber) {
    this.meetingNumber = meetingNumber;
  }

  @override
  List<Object?> get props => [
        date,
        id,
        topics,
      ];
}
