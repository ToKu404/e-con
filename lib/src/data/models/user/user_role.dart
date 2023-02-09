import 'package:equatable/equatable.dart';

class UserRole extends Equatable {
  final int id;

  UserRole({
    required this.id,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
        id: (json['aksesId']),
      );

  @override
  List<Object?> get props => [id];
}
