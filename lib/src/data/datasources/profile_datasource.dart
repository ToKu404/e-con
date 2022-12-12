import 'dart:convert';

import 'package:e_con/core/common/auth_preference_helper.dart';
import 'package:e_con/core/common/exception.dart';
import 'package:e_con/core/responses/data_response.dart';
import 'package:e_con/core/services/api_service.dart';
import 'package:e_con/src/data/models/profile/lecture_data.dart';
import 'package:e_con/src/data/models/profile/student_data.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

abstract class ProfileDataSource {
  Future<StudentData> getStudentData();
  Future<LectureData> getLectureData();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final http.Client client;
  final AuthPreferenceHelper authPreferenceHelper;

  ProfileDataSourceImpl({
    required this.client,
    required this.authPreferenceHelper,
  });

  @override
  Future<LectureData> getLectureData() async {
    String token = '';
    try {
      final userCredential = await authPreferenceHelper.getUser();
      token = userCredential!.token ?? '';
    } catch (e) {
      throw LocalDatabaseException();
    }

    Map<String, dynamic> payload = Jwt.parseJwt(token);

    final response = await client.get(
      Uri.parse(
          '${ApiService.baseUrlFinalExam}/lecturers/${payload['username']}'),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    print(response.body);

    if (response.statusCode == 200) {
      final dataResponse =
          DataResponse<Map<String, dynamic>>.fromJson(jsonDecode(response.body))
              .data;
      final userData = LectureData.fromJson(dataResponse);
      return userData;
    } else if (response.statusCode == 404) {
      throw UserNotFoundException();
    } else {
      throw AuthException();
    }
  }

  @override
  Future<StudentData> getStudentData() async {
    String token = '';
    try {
      final userCredential = await authPreferenceHelper.getUser();
      token = userCredential!.token ?? '';
    } catch (e) {
      throw LocalDatabaseException();
    }

    Map<String, dynamic> payload = Jwt.parseJwt(token);
    final response = await client.get(
      Uri.parse(
          '${ApiService.baseUrlFinalExam}/students/${payload['username']}'),
      headers: {
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      final dataResponse =
          DataResponse<Map<String, dynamic>>.fromJson(jsonDecode(response.body))
              .data;
      final userData = StudentData.fromJson(dataResponse);
      return userData;
    } else if (response.statusCode == 404) {
      throw UserNotFoundException();
    } else {
      throw AuthException();
    }
  }
}
