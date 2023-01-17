import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/src/data/models/attendance/student_data_attendance_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReusableFuntionHelper {
  static String datetimeToString(DateTime date,
      {bool isShowTime = false, String? format}) {
    return isShowTime
        ? DateFormat(format ?? 'HH:MM, dd MMMM yyyy', "id_ID").format(date)
        : DateFormat(format ?? 'EEEE, dd MMMM yyyy', "id_ID").format(date);
  }

  static DateTime stringToDateTime(String date, {bool isShowTime = false}) {
    return isShowTime
        ? DateFormat('HH:MM, dd MMMM yyyy', "id_ID").parse(date)
        : DateFormat("EEEE, dd MMMM yyyy", "id_ID").parse(date);
  }

  static bool isInitialExpiredDate(DateTime expiredDate) {
    final dateTime = expiredDate;
    final initDate = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );
    return initDate.isAtSameMomentAs(expiredDate);
  }

  static StudentAttendanceStat getAttendanceStat(
      {required List<StudentDataAttendanceData> attendances}) {
    int percent = 100;
    int countNotAbsent = 0;
    Color? statusColor;

    if (attendances.isNotEmpty) {
      final length = attendances.length;
      int countAbsent = 0;
      for (var element in attendances) {
        if (element.attendanceType!.id == 1) {
          countAbsent++;
        } else {
          countNotAbsent++;
        }
      }
      percent = ((countAbsent / length) * 100).round();
    }
    if (countNotAbsent <= 1) {
      statusColor = Palette.success;
    } else if (countNotAbsent == 2) {
      statusColor = Palette.warning;
    } else if (countNotAbsent == 3) {
      statusColor = Palette.danger;
    } else {
      statusColor = Palette.disable;
    }
    return StudentAttendanceStat(percent: percent, statusColor: statusColor);
  }
}

class StudentAttendanceStat {
  final int percent;
  final Color statusColor;

  StudentAttendanceStat({required this.percent, required this.statusColor});
}
