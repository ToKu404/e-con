import 'dart:convert';

import 'package:e_con/core/helpers/auth_preference_helper.dart';
import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/core/responses/data_response.dart';
import 'package:e_con/core/services/api_service.dart';
import 'package:e_con/src/data/models/cpl_lecturer/course_content.dart';
import 'package:e_con/src/data/models/cpl_lecturer/course_student_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:e_con/src/data/models/profile/student_data.dart';
import 'package:http/http.dart' as http;

abstract class CplLecturerDataSource {
  Future<CourseContent> getListCourse();
  Future<List<MeetingData>> getListMeeting(int classId);
  Future<List<CourseStudentData>> getListStudent(int classId);
}

class CplLecturerDataSourceImpl implements CplLecturerDataSource {
  final http.Client client;
  final AuthPreferenceHelper authPreferenceHelper;

  CplLecturerDataSourceImpl(
      {required this.client, required this.authPreferenceHelper});

  @override
  Future<CourseContent> getListCourse() async {
    final credential = await authPreferenceHelper.getUser();
    final responseData = await client.get(
      Uri.parse('${ApiService.baseUrlCPL}/dosen-authority/daftar-kelas'),
      headers: {
        "Cookie": credential!.session ?? '',
      },
    );

    if (responseData.statusCode == 200) {
      final dataResponse = DataResponse<Map<String, dynamic>>.fromJson(
              jsonDecode(responseData.body))
          .data;

      final userCredential = CourseContent.fromJson(dataResponse);
      return userCredential;
    } else if (responseData.statusCode == 401) {
      throw UnauthenticateException();
    } else if (responseData.statusCode == 404) {
      throw UserNotFoundException();
    } else {
      throw AuthException();
    }
  }

  @override
  Future<List<MeetingData>> getListMeeting(int classId) async {
    final credential = await authPreferenceHelper.getUser();
    final responseData = await client.get(
      Uri.parse(
          '${ApiService.baseUrlCPL}/class-record/meeting/all-by-classid/$classId'),
      headers: {
        "Cookie": credential!.session ?? '',
      },
    );

    if (responseData.statusCode == 200) {
      Iterable dataResponse =
          DataResponse<List<dynamic>>.fromJson(jsonDecode(responseData.body))
              .data;

      return List<MeetingData>.from(
        dataResponse.map(
          (e) => MeetingData.fromJson(e),
        ),
      );
    } else if (responseData.statusCode == 401) {
      throw UnauthenticateException();
    } else if (responseData.statusCode == 404) {
      throw UserNotFoundException();
    } else {
      throw AuthException();
    }
  }

  @override
  Future<List<CourseStudentData>> getListStudent(int classId) async {
    final credential = await authPreferenceHelper.getUser();
    final responseData = await client.get(
      Uri.parse(
          '${ApiService.baseUrlCPL}/class-record/student/all-by-classid/$classId'),
      headers: {
        "Cookie": credential!.session ?? '',
      },
    );

    if (responseData.statusCode == 200) {
      Iterable dataResponse =
          DataResponse<List<dynamic>>.fromJson(jsonDecode(responseData.body))
              .data;
      return List<CourseStudentData>.from(
        dataResponse.map(
          (e) => CourseStudentData.fromJson(e),
        ),
      );
    } else if (responseData.statusCode == 401) {
      throw UnauthenticateException();
    } else if (responseData.statusCode == 404) {
      throw UserNotFoundException();
    } else {
      throw AuthException();
    }
  }
}
