import 'package:equatable/equatable.dart';

class UserRole extends Equatable {
  final int id;
  final String name;

  UserRole({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
