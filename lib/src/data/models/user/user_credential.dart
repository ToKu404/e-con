
import 'package:e_con/src/data/models/user/user_role.dart';
import 'package:equatable/equatable.dart';

class UserCredential extends Equatable {
  final UserRole? role;
  final String? token;
  final String? session;

  const UserCredential({
    required this.role,
    required this.token,
    required this.session,
  }) : super();

  factory UserCredential.fromJson(Map<String, dynamic> json, String session) =>
      UserCredential(
        role: UserRole.fromJson(json['role']),
        token: json['token'] as String,
        session: session,
      );

  @override
  List<Object?> get props => [role, token];
}
