import 'dart:convert';

import 'package:e_con/core/helpers/auth_preference_helper.dart';
import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/core/responses/data_response.dart';
import 'package:e_con/core/services/api_service.dart';
import 'package:e_con/src/data/models/cpl_lecturer/classs_content.dart';
import 'package:e_con/src/data/models/profile/student_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

abstract class CplLecturerDataSource {
  Future<ClazzContent> getListClazz();
  Future<List<MeetingData>> getListMeeting(int classId);
  Future<List<StudentData>> getListStudent(int classId);
  Future<bool> createNewMeeting({
    required int classId,
    required String topic,
    required DateTime meetingDate,
  });
  Future<bool> deleteMeeting({required int meetingId});
  Future<bool> updateMeeting({
    int? classId,
    String? topic,
    DateTime? meetingDate,
    required meetingId,
  });
  Future<String> getValidationCode({required int meetingId});
  Future<bool> setAttendanceExpiredDate(
      {required DateTime expiredDate, required int meetingId});
  Future<MeetingData> getMeetingData({required int meetingId});
}

class CplLecturerDataSourceImpl implements CplLecturerDataSource {
  final http.Client client;
  final AuthPreferenceHelper authPreferenceHelper;

  CplLecturerDataSourceImpl(
      {required this.client, required this.authPreferenceHelper});

  @override
  Future<ClazzContent> getListClazz() async {
    final credential = await authPreferenceHelper.getUser();
    final responseData = await client.get(
      Uri.parse('${ApiService.baseUrlCPL}/class-record/classes'),
      headers: {
        "Cookie": credential!.session ?? '',
      },
    );

    if (responseData.statusCode == 200) {
      final dataResponse = DataResponse<Map<String, dynamic>>.fromJson(
              jsonDecode(responseData.body))
          .data;

      final userCredential = ClazzContent.fromJson(dataResponse);
      return userCredential;
    } else if (responseData.statusCode == 401) {
      throw UnauthenticateException();
    } else if (responseData.statusCode == 404) {
      throw DataNotFoundException();
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
      throw DataNotFoundException();
    } else {
      throw AuthException();
    }
  }

  @override
  Future<List<StudentData>> getListStudent(int classId) async {
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
      return List<StudentData>.from(
        dataResponse.map(
          (e) => StudentData.fromJson(e),
        ),
      );
    } else if (responseData.statusCode == 401) {
      throw UnauthenticateException();
    } else if (responseData.statusCode == 404) {
      throw DataNotFoundException();
    } else {
      throw AuthException();
    }
  }

  @override
  Future<bool> createNewMeeting(
      {required int classId,
      required String topic,
      required DateTime meetingDate}) async {
    final credential = await authPreferenceHelper.getUser();

    final map = {
      'date': DateFormat('yyyy-MM-dd').format(meetingDate),
      'topics': topic,
      'clazzId': classId,
    };
    final response = await client.post(
      Uri.parse('${ApiService.baseUrlCPL}/class-record/meeting'),
      headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
        "Cookie": credential!.session ?? '',
      },
      body: json.encode(map),
    );

    return response.statusCode == 200;
  }

  @override
  Future<bool> deleteMeeting({required int meetingId}) async {
    final credential = await authPreferenceHelper.getUser();
    final response = await client.delete(
      Uri.parse('${ApiService.baseUrlCPL}/class-record/meeting/$meetingId'),
      headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
        "Cookie": credential!.session ?? '',
      },
    );

    return response.statusCode == 200;
  }

  @override
  Future<bool> updateMeeting(
      {int? classId,
      String? topic,
      DateTime? meetingDate,
      required meetingId}) async {
    final credential = await authPreferenceHelper.getUser();

    final map = {
      if (meetingDate != null)
        'date': DateFormat('yyyy-MM-dd').format(meetingDate),
      if (topic != null) 'topics': topic,
      if (classId != null) 'clazzId': classId,
    };
    final response = await client.put(
      Uri.parse('${ApiService.baseUrlCPL}/class-record/meeting/$meetingId'),
      headers: {
        'Content-Type': 'application/json',
        'charset': 'utf-8',
        "Cookie": credential!.session ?? '',
      },
      body: json.encode(map),
    );
    return response.statusCode == 200;
  }

  @override
  Future<String> getValidationCode({required int meetingId}) async {
    final credential = await authPreferenceHelper.getUser();

    final responseData = await client.get(
      Uri.parse(
          '${ApiService.baseUrlCPL}/class-record/meeting/${meetingId}/validation-code'),
      headers: {
        "Cookie": credential!.session ?? '',
      },
    );
    if (responseData.statusCode == 200) {
      final data =
          DataResponse<String>.fromJson(jsonDecode(responseData.body)).data;

      return data;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<bool> setAttendanceExpiredDate(
      {required DateTime expiredDate, required int meetingId}) async {
    final credential = await authPreferenceHelper.getUser();

    final map = {
      'dateTime': DateFormat('dd.MM.yyyy HH:mm').format(expiredDate),
    };

    final response = await client.put(
      Uri.parse(
        '${ApiService.baseUrlCPL}/class-record/meeting/${meetingId}/validation-code-expiration-datetime',
      ).replace(queryParameters: map),
      headers: {
        'Content-Type': 'application/json',
        "Cookie": credential!.session ?? '',
      },
    );

    return response.statusCode == 200;
  }

  @override
  Future<MeetingData> getMeetingData({required int meetingId}) async {
    final credential = await authPreferenceHelper.getUser();
    final responseData = await client.get(
      Uri.parse('${ApiService.baseUrlCPL}/class-record/meeting/${meetingId}'),
      headers: {
        "Cookie": credential!.session ?? '',
      },
    );

    if (responseData.statusCode == 200) {
      final dataResponse = DataResponse<Map<String, dynamic>>.fromJson(
              jsonDecode(responseData.body))
          .data;

      final meetingData = MeetingData.fromJson(dataResponse);
      return meetingData;
    } else if (responseData.statusCode == 404) {
      throw DataNotFoundException();
    } else {
      throw ServerException();
    }
  }
}
