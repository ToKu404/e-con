import 'dart:convert';

import 'package:e_con/core/helpers/auth_preference_helper.dart';
import 'package:e_con/core/responses/data_response.dart';
import 'package:e_con/core/services/api_service.dart';
import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/src/data/models/attendance/attendance_data.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

abstract class AttendanceDataSource {
  Future<bool> setAttendance(
      {required int meetingId,
      required int studentId,
      required attendanceTypeId});
  Future<List<AttendanceData>> getListAttendance({
    required int meetingId,
  });
}

class AttendanceDataSourceImpl implements AttendanceDataSource {
  final http.Client client;
  final AuthPreferenceHelper authPreferenceHelper;

  AttendanceDataSourceImpl(
      {required this.client, required this.authPreferenceHelper});
  @override
  Future<bool> setAttendance(
      {required int meetingId,
      required int studentId,
      required attendanceTypeId}) async {
    final credential = await authPreferenceHelper.getUser();

    final map = {
      'meetingId': meetingId,
      'studentId': studentId,
      'attendanceTypeId': attendanceTypeId,
    };

    final response = await client.post(
      Uri.parse(
        '${ApiService.baseUrlCPL}/class-record/attendance',
      ).replace(queryParameters: map),
      headers: {
        'Content-Type': 'application/json',
        "Cookie": credential!.session ?? '',
      },
    );

    return response.statusCode == 200;
  }

  @override
  Future<List<AttendanceData>> getListAttendance({
    required int meetingId,
  }) async {
    final credential = await authPreferenceHelper.getUser();
    final responseData = await client.get(
      Uri.parse(
          '${ApiService.baseUrlCPL}/class-record/attendance/all-by-meetingid/${meetingId}'),
      headers: {
        "Cookie": credential!.session ?? '',
      },
    );

    if (responseData.statusCode == 200) {
      Iterable dataResponse =
          DataResponse<List<dynamic>>.fromJson(jsonDecode(responseData.body))
              .data;
      return List<AttendanceData>.from(
        dataResponse.map(
          (e) => AttendanceData.fromJson(e),
        ),
      );
    } else {
      throw ServerException();
    }
  }
}
