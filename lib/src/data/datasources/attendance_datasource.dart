import 'dart:convert';

import 'package:e_con/core/helpers/auth_preference_helper.dart';
import 'package:e_con/core/responses/data_response.dart';
import 'package:e_con/core/services/api_service.dart';
import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/src/data/models/attendance/attendance_data.dart';
import 'package:e_con/src/data/models/attendance/student_attendance_data.dart';
import 'package:http/http.dart' as http;

abstract class AttendanceDataSource {
  Future<bool> setAttendance(
      {required int meetingId,
      required int studentId,
      required int attendanceTypeId,
      required int attendanceId});
  Future<bool> setAttendanceByStudent({
    required int meetingId,
    required int studentId,
    required int attendanceTypeId,
  });
  Future<List<AttendanceData>> getListAttendance({
    required int meetingId,
    required String? query,
  });
  Future<List<StudentAttendanceData>> getListStudentAttendance({
    required int classId,
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
      required int attendanceTypeId,
      required int attendanceId}) async {
    final credential = await authPreferenceHelper.getUser();

    final map = {
      'meetingId': meetingId,
      'studentId': studentId,
      'attendanceTypeId': attendanceTypeId,
      'id': attendanceId
    };
    final response = await client.put(
      Uri.parse(
        '${ApiService.baseUrlCPL}/class-record/attendance/${attendanceId}',
      ),
      headers: {
        'Content-Type': 'application/json',
        "Cookie": credential!.session ?? '',
      },
      body: jsonEncode(map),
    );
    return response.statusCode == 200;
  }

  @override
  Future<List<AttendanceData>> getListAttendance({
    required int meetingId,
    required String? query,
  }) async {
    final credential = await authPreferenceHelper.getUser();
    final map = {
      'query': query,
    };

    final responseData = await client.get(
      Uri.parse(
        '${ApiService.baseUrlCPL}/class-record/attendance/all-by-meetingid/${meetingId}',
      ).replace(queryParameters: map),
      headers: {
        "Cookie": credential!.session ?? '',
      },
    );

    if (responseData.statusCode == 200) {
      print(meetingId);
      Iterable dataResponse =
          DataResponse<List<dynamic>>.fromJson(jsonDecode(responseData.body))
              .data;
      return List<AttendanceData>.from(
        dataResponse.map(
          (e) => AttendanceData.fromJson(e),
        ),
      );
    } else if (responseData.statusCode == 404) {
      throw DataNotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<StudentAttendanceData>> getListStudentAttendance(
      {required int classId}) async {
    final credential = await authPreferenceHelper.getUser();

    final responseData = await client.get(
      Uri.parse(
        '${ApiService.baseUrlCPL}/class-record/student/attendance/all-by-classid/${classId}',
      ),
      headers: {
        "Cookie": credential!.session ?? '',
      },
    );
    if (responseData.statusCode == 200) {
      Iterable dataResponse =
          DataResponse<List<dynamic>>.fromJson(jsonDecode(responseData.body))
              .data;
      return List<StudentAttendanceData>.from(
        dataResponse.map(
          (e) => StudentAttendanceData.fromJson(e),
        ),
      );
    } else if (responseData.statusCode == 404) {
      throw DataNotFoundException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> setAttendanceByStudent(
      {required int meetingId,
      required int studentId,
      required int attendanceTypeId}) async {
    try {
      final credential = await authPreferenceHelper.getUser();

      final map = {
        'meetingId': meetingId,
        'studentId': studentId,
        'attendanceTypeId': attendanceTypeId,
      };
      final response = await client.post(
        Uri.parse(
          '${ApiService.baseUrlCPL}/class-record/attendance',
        ),
        headers: {
          'Content-Type': 'application/json',
          "Cookie": credential!.session ?? '',
        },
        body: jsonEncode(map),
      );
      print(response.body);
      return response.statusCode == 200;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
