import 'package:e_con/core/constants/color_const.dart';
import 'package:e_con/src/data/models/attendance/student_data_attendance_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/statistic_data.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// A collection of functions that are reusable
class ReusableFuntionHelper {
  /// Convert DateTime to String
  static String datetimeToString(DateTime date,
      {bool isShowTime = false, String? format}) {
    return isShowTime
        ? DateFormat(format ?? 'HH:MM, dd MMMM yyyy', "id_ID").format(date)
        : DateFormat(format ?? 'EEEE, dd MMMM yyyy', "id_ID").format(date);
  }

  /// Convert String to DateTime
  static DateTime stringToDateTime(String date, {bool isShowTime = false}) {
    return isShowTime
        ? DateFormat('HH:MM, dd MMMM yyyy', "id_ID").parse(date)
        : DateFormat("EEEE, dd MMMM yyyy", "id_ID").parse(date);
  }

  /// Check if expired date same moment with datetime now
  static bool isInitialExpiredDate(DateTime expiredDate) {
    final dateTime = expiredDate;
    final initDate = DateTime(
      dateTime.year,
      dateTime.month,
      dateTime.day,
    );
    return initDate.isAtSameMomentAs(expiredDate);
  }

  /// calculate value of statistic attendance
  static Map<int, int> getStatisticValue(List<StatisticData> statistics) {
    final result = {1: 0, 2: 0, 3: 0, 4: 0};
    for (int i = 0; i < statistics.length; i++) {
      result[statistics[i].attendance!.id!] = statistics[i].score!;
    }
    return result;
  }

  /// convert student statistic attendance to percent and color
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

  /// get attendance color by type
  static Color getAttendanceColor(int type) {
    switch (type) {
      case 1:
        return Palette.success;
      case 2:
        return Palette.danger;
      case 3:
        return Palette.warning;
      case 4:
        return Colors.blue;
      default:
        return Palette.disable;
    }
  }

  /// check status of meeting
  static MeetingStatus checkStatusMeeting(DateTime date) {
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);
    if (date.isAtSameMomentAs(now)) {
      return MeetingStatus(color: Palette.primary, status: 'Aktif');
    } else if (date.isBefore(now)) {
      return MeetingStatus(color: Palette.teritory, status: 'Selesai');
    } else {
      return MeetingStatus(color: Palette.disable, status: 'Belum Mulai');
    }
  }

  /// check status of meeting
  static List<WeeklyActivity> getWeeklyActivityData() {
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);
    final dayNameNow = DateFormat('EEEE', "id_ID").format(now);

    final dayName = [
      'Sen',
      'Sel',
      'Rab',
      'Kam',
      'Jum',
      'Sab',
      'Min',
    ];
    int index = 1;
    for (var i = 1; i <= dayName.length; i++) {
      if (dayName[i - 1] == dayNameNow.substring(0, 3)) {
        index = i;
        break;
      }
    }
    List<WeeklyActivity> listWeekly = [];

    for (var i = 1; i <= dayName.length; i++) {
      DateTime? date;
      if (index > i) {
        date = now.subtract(Duration(days: index - i));
      } else if (index == i) {
        date = now;
      } else {
        date = now.add(Duration(days: i - index));
      }
      listWeekly.add(WeeklyActivity(date: date, dateName: dayName[i - 1]));
    }
    for (var element in listWeekly) {
      print(
          '${element.dateName} ${DateFormat('dd MMMM yyyy', "id_ID").format(element.date)}');
    }
    return listWeekly;
  }

  static WeeklyActivity getTodayActivityData() {
    DateTime now = DateTime.now();
    now = DateTime(now.year, now.month, now.day);
    final dayNameNow = DateFormat('EEEE', "id_ID").format(now);
    return WeeklyActivity(
        date: now,
        dateName: dayNameNow[0].toUpperCase() +
            dayNameNow.substring(1, 3).toLowerCase());
  }

  static String titleMaker(String title) {
    final listTitle = title.split(' ');
    String newTitle = '';
    for (var t in listTitle) {
      newTitle += t[0].toUpperCase() + t.substring(1, t.length) + " ";
    }
    return newTitle.trim();
  }
}

class WeeklyActivity extends Equatable {
  final String dateName;
  final DateTime date;

  WeeklyActivity({required this.date, required this.dateName});

  @override
  List<Object?> get props => [dateName];
}

class StudentAttendanceStat {
  final int percent;
  final Color statusColor;

  StudentAttendanceStat({required this.percent, required this.statusColor});
}

class MeetingStatus {
  final String status;
  final Color color;
  MeetingStatus({required this.color, required this.status});
}
