import 'package:e_con/src/data/models/user_credential.dart';
import 'package:equatable/equatable.dart';

class UserResponse extends Equatable {
  const UserResponse({required this.data, this.message, this.status});

  final UserCredential data;
  final String? message;
  final String? status;

  factory UserResponse.fromJson(
    Map<String, dynamic> json,
  ) =>
      UserResponse(
        data: UserCredential.fromJson(json['data']),
        message: json['message'],
        status: json['status'],
      );
  @override
  List<Object?> get props => [data, message, status];
}
