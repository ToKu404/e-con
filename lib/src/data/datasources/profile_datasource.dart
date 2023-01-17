import 'dart:convert';

import 'package:e_con/core/helpers/auth_preference_helper.dart';
import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/core/responses/data_response.dart';
import 'package:e_con/core/services/api_service.dart';
import 'package:e_con/src/data/models/profile/lecture_data.dart';
import 'package:e_con/src/data/models/profile/student_data.dart';
import 'package:e_con/src/data/models/profile/student_home.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

abstract class ProfileDataSource {
  Future<StudentData> getStudentData();
  Future<LectureData> getLectureData();
  Future<Uint8List?> getProfilePicture();
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
    // String token = '';
    String session = '';
    try {
      final userCredential = await authPreferenceHelper.getUser();
      // token = userCredential!.token ?? '';
      session = userCredential!.session ?? '';
    } catch (e) {
      throw LocalDatabaseException();
    }

    // Map<String, dynamic> payload = Jwt.parseJwt(token);

    final responseData = await client.get(
      Uri.parse('${ApiService.baseUrlCPL}/dosen-authority/profile'),
      headers: {
        "Cookie": session,
      },
    );

    print(responseData.body);

    if (responseData.statusCode == 200) {
      final dataResponse = DataResponse<Map<String, dynamic>>.fromJson(
              jsonDecode(responseData.body))
          .data;
      final userData = LectureData.fromJson(dataResponse);
      return userData;
    } else if (responseData.statusCode == 404) {
      throw UserNotFoundException();
    } else {
      throw AuthException();
    }
  }

  @override
  Future<StudentData> getStudentData() async {
    // String token = '';
    String session = '';
    try {
      final userCredential = await authPreferenceHelper.getUser();
      // token = userCredential!.token ?? '';
      session = userCredential!.session ?? '';
    } catch (e) {
      throw LocalDatabaseException();
    }

    // Map<String, dynamic> payload = Jwt.parseJwt(token);

    final responseData = await client.get(
      Uri.parse('${ApiService.baseUrlCPL}/mahasiswa-authority/home'),
      headers: {
        "Cookie": session,
      },
    );

    print(responseData.body);

    if (responseData.statusCode == 200) {
      final dataResponse = DataResponse<Map<String, dynamic>>.fromJson(
              jsonDecode(responseData.body))
          .data;
      final userData = StudentHome.fromJson(dataResponse).profile!;
      return userData;
    } else if (responseData.statusCode == 404) {
      throw UserNotFoundException();
    } else {
      throw AuthException();
    }
  }

  @override
  Future<Uint8List?> getProfilePicture() async {
    final credential = await authPreferenceHelper.getUser();
    final responseData = await client.get(
      Uri.parse('${ApiService.baseUrlCPL}/user/profile-picture'),
      headers: {
        "Cookie": credential!.session ?? '',
      },
    );
    if (responseData.statusCode == 200) {
      final data = responseData.bodyBytes;

      return data;
    } else if (responseData.statusCode == 404) {
      throw DataNotFoundException();
    } else {
      ServerException();
    }
    return null;
  }
}
