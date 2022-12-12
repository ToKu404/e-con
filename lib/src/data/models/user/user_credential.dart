import 'package:e_con/src/data/models/user/helper/user_role_type.dart';
import 'package:equatable/equatable.dart';

class UserCredential extends Equatable {
  final UserRole? role;
  final String? token;
  final String? session;
  const UserCredential(
      {required this.role, required this.token, required this.session})
      : super();

  factory UserCredential.fromJson(Map<String, dynamic> json, String session) =>
      UserCredential(
        role: (json['role']) == 7
            ? UserRole.student
            : (json['role']) == 6
                ? UserRole.teacher
                : null,
        token: json['token'] as String,
        session: session,
      );

  @override
  List<Object?> get props => [role, token];
}
