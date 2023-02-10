import 'dart:convert';

import 'package:e_con/core/helpers/auth_preference_helper.dart';
import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/core/responses/data_response.dart';
import 'package:e_con/core/services/api_service.dart';
import 'package:e_con/src/data/models/profile/notification.dart';
import 'package:e_con/src/data/models/profile/lecture_data.dart';
import 'package:e_con/src/data/models/profile/student_data.dart';
import 'package:e_con/src/data/models/profile/student_home.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

abstract class ProfileDataSource {
  Future<StudentData> singleStudentProfile();
  Future<LectureData> singleLecturerProfile();
  Future<Uint8List?> getUserProfilePicture();
  Future<List<NotificationModel>> getNotification();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final http.Client client;
  final AuthPreferenceHelper authPreferenceHelper;

  ProfileDataSourceImpl({
    required this.client,
    required this.authPreferenceHelper,
  });

  /// Mendapatkan data profile dosen
  /// https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/dosen-authority-controller/menuNilaiDosenProfile
  /// Get
  @override
  Future<LectureData> singleLecturerProfile() async {
    String session = '';
    try {
      final userCredential = await authPreferenceHelper.getUser();
      session = userCredential!.session ?? '';
    } catch (e) {
      throw LocalDatabaseException();
    }

    final responseData = await client.get(
      Uri.parse('${ApiService.baseUrlCPL}/dosen-authority/profile'),
      headers: {
        "Cookie": session,
      },
    );

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

  /// Mendapatkan data profile student
  /// https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/mahasiswa-authority-controller/home
  /// Get
  @override
  Future<StudentData> singleStudentProfile() async {
    String session = '';
    try {
      final userCredential = await authPreferenceHelper.getUser();
      session = userCredential!.session ?? '';
    } catch (e) {
      throw LocalDatabaseException();
    }

    final responseData = await client.get(
      Uri.parse('${ApiService.baseUrlCPL}/mahasiswa-authority/home'),
      headers: {
        "Cookie": session,
      },
    );
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

  /// Mendaptatkan foto profile user yang login
  /// https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/user-controller/downloadProfilePicture
  /// Get
  @override
  Future<Uint8List?> getUserProfilePicture() async {
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

  /// Notif

  @override
  Future<List<NotificationModel>> getNotification() async {
    try {
      final credential = await authPreferenceHelper.getUser();
      

      final responseData = await client.get(
        Uri.parse(
          '${ApiService.baseUrlFinalExam}/notifications',
        ),
        headers: {
          "Authorization": "Bearer ${credential!.token}",
        },
      );
      print(responseData.body);
      if (responseData.statusCode == 200) {
        Iterable dataResponse =
            DataResponse<List<dynamic>>.fromJson(jsonDecode(responseData.body))
                .data;
        return List<NotificationModel>.from(
          dataResponse.map(
            (e) => NotificationModel.fromJson(e),
          ),
        );
      } else if (responseData.statusCode == 404) {
        return [];
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      throw ServerException();
    }
  }
}
