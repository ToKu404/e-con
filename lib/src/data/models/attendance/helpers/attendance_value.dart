import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/core/constants/path_const.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AttendanceValue extends Equatable {
  final String iconPath;
  final String status;
  final Color color;
  final int id;

  AttendanceValue({
    required this.color,
    required this.iconPath,
    required this.id,
    required this.status,
  });

  @override
  List<Object?> get props => [id];
}

class AttendanceValueHelper {
  static final _dataAttendance = [
    AttendanceValue(
        color: Palette.disable,
        iconPath: AssetPath.iconNotAttend,
        id: 2,
        status: 'Alpa'),
    AttendanceValue(
        color: Palette.secondary,
        iconPath: AssetPath.iconPermission,
        id: 4,
        status: 'Izin'),
    AttendanceValue(
        color: Palette.warning,
        iconPath: AssetPath.iconSick,
        id: 3,
        status: 'Sakit'),
    AttendanceValue(
        color: Palette.success,
        iconPath: AssetPath.iconAttend,
        id: 1,
        status: 'Hadir'),
  ];
  static AttendanceValue getAttendanceValue(int id) {
    return _dataAttendance[id - 1];
  }

  static List<AttendanceValue> getAllAttendance() {
    return _dataAttendance;
  }
}

enum AbsentStatus { hadir, izin, tidakHadir, sakit }
