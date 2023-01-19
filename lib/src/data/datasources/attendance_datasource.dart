import 'dart:convert';

import 'package:e_con/core/helpers/auth_preference_helper.dart';
import 'package:e_con/core/responses/data_response.dart';
import 'package:e_con/core/services/api_service.dart';
import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/src/data/models/attendance/attendance_data.dart';
import 'package:e_con/src/data/models/attendance/student_attendance_data.dart';
import 'package:http/http.dart' as http;

abstract class AttendanceDataSource {
  Future<bool> updateAttendanceStatus(
      {required int meetingId,
      required int studentId,
      required int attendanceTypeId,
      required int attendanceId});
  Future<bool> attendByStudent({
    required int meetingId,
    required int studentId,
    required String validationCode,
  });
  Future<List<AttendanceData>> fetchAllStudentAttendanceByMeeting({
    required int meetingId,
    required String? query,
  });
  Future<List<StudentAttendanceData>> fetchAllStudentAttendanceByClass({
    required int classId,
  });
}

class AttendanceDataSourceImpl implements AttendanceDataSource {
  final http.Client client;
  final AuthPreferenceHelper authPreferenceHelper;

  AttendanceDataSourceImpl(
      {required this.client, required this.authPreferenceHelper});
  @override

  /// Digunakan oleh role dosen untuk merubah status absensi
  /// https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/class-record-controller/updateAttendance
  /// METHOD : PUT
  Future<bool> updateAttendanceStatus(
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

  /// Digunakan oleh dosen untuk mendapatkan list mahasiswa dan absensinya berdasarkan id pertemuan
  /// https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/class-record-controller/findAllAttendanceByMeetingId
  /// Method : Get
  /// Terdapat fitur Search

  @override
  Future<List<AttendanceData>> fetchAllStudentAttendanceByMeeting({
    required int meetingId,
    required String? query,
  }) async {
    final credential = await authPreferenceHelper.getUser();
    final map = {
      'query': query,
    };
    try {
      final responseData = await client.get(
        Uri.parse(
          '${ApiService.baseUrlCPL}/class-record/attendance/all-by-meetingid/${meetingId}',
        ).replace(queryParameters: map),
        headers: {
          "Cookie": credential!.session ?? '',
        },
      );
      responseData.body;
      if (responseData.statusCode == 200) {
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
    } catch (e) {
      throw ServerException();
    }
  }

  /// Digunakan oleh role dosen untuk mendapatkan seluruh list mahasiswa yang terdaftar di kelas tersebut beserta attendancenya
  /// https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/class-record-controller/findAllAttendanceByClassId
  /// Method : Get
  @override
  Future<List<StudentAttendanceData>> fetchAllStudentAttendanceByClass(
      {required int classId}) async {
    final credential = await authPreferenceHelper.getUser();

    final responseData = await client.get(
      Uri.parse(
        '${ApiService.baseUrlCPL}/class-record/attendance/all-by-classid/${classId}',
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

  /// Digunakan oleh role student untuk merubah status absensi menjadi attend
  /// https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/class-record-controller/validateAndUpdateStudentAttendance
  /// Method : Post
  @override
  Future<bool> attendByStudent(
      {required int meetingId,
      required int studentId,
      required String validationCode}) async {
    try {
      final credential = await authPreferenceHelper.getUser();

      final map = {
        'meetingId': meetingId,
        'studentId': studentId,
        'validationCode': validationCode,
      };
      final response = await client.post(
          Uri.parse(
            '${ApiService.baseUrlCPL}/class-record/student/validate-attendance',
          ).replace(
              queryParameters:
                  map.map((key, value) => MapEntry(key, value.toString()))),
          headers: {
            'Content-Type': 'application/json',
            "Cookie": credential!.session ?? '',
          },
          body: jsonEncode(map));

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
