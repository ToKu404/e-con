import 'dart:convert';

import 'package:e_con/core/helpers/auth_preference_helper.dart';
import 'package:e_con/core/responses/data_response.dart';
import 'package:e_con/core/services/api_service.dart';
import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/src/data/models/attendance/attendance_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:http/http.dart' as http;

abstract class CplStudentDataSource {
  Future<List<ClazzData>> getListStudentClass();
  Future<List<AttendanceData>> getListStudentAttendance({required int classId});
}

class CplStudentDataSourceImpl implements CplStudentDataSource {
  final http.Client client;
  final AuthPreferenceHelper authPreferenceHelper;

  CplStudentDataSourceImpl(
      {required this.client, required this.authPreferenceHelper});

  @override
  Future<List<ClazzData>> getListStudentClass() async {
    try {
      final credential = await authPreferenceHelper.getUser();
      final responseData = await client.get(
        Uri.parse('${ApiService.baseUrlCPL}/student/classes'),
        headers: {
          "Cookie": credential!.session ?? '',
        },
      );

      if (responseData.statusCode == 200) {
        Iterable dataResponse =
            DataResponse<List<dynamic>>.fromJson(jsonDecode(responseData.body))
                .data;

        return List<ClazzData>.from(
          dataResponse.map(
            (e) => ClazzData.fromJson(e),
          ),
        );
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      throw ServerException();
    }
  }

  @override
  Future<List<AttendanceData>> getListStudentAttendance(
      {required int classId}) async {
    try {
      final credential = await authPreferenceHelper.getUser();
      final responseData = await client.get(
        Uri.parse(
            '${ApiService.baseUrlCPL}/student/attendance/all-by-classid/${classId}'),
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
    } catch (e) {
      print(e.toString());
      throw ServerException();
    }
  }
}
