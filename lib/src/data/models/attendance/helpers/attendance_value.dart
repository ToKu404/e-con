import 'package:e_con/core/constants/color_const.dart';
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
  // TODO: implement props
  List<Object?> get props => [id];
}

class AttendanceValueHelper {
  static final _dataAttendance = [
    AttendanceValue(
        color: Palette.success,
        iconPath: 'assets/icons/smile.svg',
        id: 1,
        status: 'Hadir'),
    AttendanceValue(
        color: Palette.disable,
        iconPath: 'assets/icons/unhappy.svg',
        id: 2,
        status: 'Alpa'),
    AttendanceValue(
        color: Palette.warning,
        iconPath: 'assets/icons/sick.svg',
        id: 3,
        status: 'Sakit'),
    AttendanceValue(
        color: Colors.blue,
        iconPath: 'assets/icons/natural.svg',
        id: 4,
        status: 'Izin'),
  ];
  static AttendanceValue getAttendanceValue(int id) {
    return _dataAttendance[id - 1];
  }

  static List<AttendanceValue> getAllAttendance() {
    return _dataAttendance;
  }
}

enum AbsentStatus { hadir, izin, tidakHadir, sakit }
