import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final int? notifId;
  final int? notifStatus;
  final String? message;
  final DateTime? createdAt;

  NotificationModel(
      {this.createdAt, this.message, this.notifId, this.notifStatus});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
        message: json['message'],
        createdAt: json['created_at'] != null
            ? DateTime.parse(json['created_at'])
            : null,
        notifId: json['notifId'],
        notifStatus: json['notifStatus']);
  }

  @override
  List<Object?> get props => [message, createdAt, notifId, notifStatus];
}
