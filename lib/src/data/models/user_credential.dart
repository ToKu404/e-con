import 'package:e_con/src/data/models/user_role.dart';
import 'package:equatable/equatable.dart';

class UserCredential extends Equatable {
  final UserRole? role;
  final String? token;
  const UserCredential({
    required this.role,
    required this.token,
  }) : super();

  factory UserCredential.fromJson(Map<String, dynamic> json) => UserCredential(
      role: (json['role']) == 7
          ? UserRole.student
          : (json['role']) == 8
              ? UserRole.teacher
              : null,
      token: json['token'] as String);

  @override
  List<Object?> get props => [role, token];
}
