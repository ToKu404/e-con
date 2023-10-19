import 'dart:convert';

import 'package:e_con/core/helpers/auth_preference_helper.dart';
import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/core/responses/data_response.dart';
import 'package:e_con/core/services/api_service.dart';
import 'package:e_con/src/data/models/cpl_lecturer/class_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/classs_content.dart';
import 'package:e_con/src/data/models/cpl_lecturer/statistic_data.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

abstract class CplLecturerDataSource {
  Future<ClazzContent> fetchLecturerClasses();
  Future<List<MeetingData>> fetchMeetingByClassId(int classId);
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
  Future<String> getMeetingValidationCode({required int meetingId});
  Future<bool> setAttendanceExpiredDate(
      {required DateTime expiredDate, required int meetingId});
  Future<MeetingData> singleMeetingData({required int meetingId});
  Future<List<StatisticData>> singleMeetingAttendanceStatistic(
      {required int meetingId});
}

class CplLecturerDataSourceImpl implements CplLecturerDataSource {
  final http.Client client;
  final AuthPreferenceHelper authPreferenceHelper;

  CplLecturerDataSourceImpl(
      {required this.client, required this.authPreferenceHelper});

  /// Digunakan untuk mendapatkan list class yang diajar oleh dosen bersangkutan
  /// https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/class-record-controller/findLecturerClasses
  /// GET
  @override
  Future<ClazzContent> fetchLecturerClasses() async {
    final credential = await authPreferenceHelper.getUser();
    final responseData = await client.get(
      Uri.parse(
          '${ApiService.baseUrlCPL}/class-record/lecturer/classes/mobile'),
      headers: {
        "Cookie": credential!.session ?? '',
      },
    );

    print(responseData.body);

    if (responseData.statusCode == 200) {
      Iterable dataResponse =
          DataResponse<List<dynamic>>.fromJson(jsonDecode(responseData.body))
              .data;

      final classData = List<ClazzData>.from(
        dataResponse.map(
          (e) => ClazzData.fromJson(e),
        ),
      );
      final userCredential = ClazzContent(listClazz: classData);

      return userCredential;
    } else if (responseData.statusCode == 401) {
      throw UnauthenticateException();
    } else if (responseData.statusCode == 404) {
      throw DataNotFoundException();
    } else {
      throw AuthException();
    }
  }

  /// Digunakan untuk mendapatkan list meeting berdasrkan kelas tertentu yang diajar dosen
  /// https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/class-record-controller/findAllMeetingByClassId
  /// Get
  @override
  Future<List<MeetingData>> fetchMeetingByClassId(int classId) async {
    try {
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
    } catch (e) {
      throw ServerException();
    }
  }

  /// Digunakan untuk membuat meeting baru pada kelas tertentu
  /// https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/class-record-controller/createMeeting
  /// Post
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

  /// Digunakan untuk menghapus meeting tertentu
  /// https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/class-record-controller/deleteMeeting
  /// Delete
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

  /// Digunakan untuk memperbaharui meeting tertentu
  /// https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/class-record-controller/updateMeeting
  /// Put
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

  /// Digunakn untuk memperoleh kode validasi dari meeeting untuk membuat absensi
  /// https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/class-record-controller/findMeetingValidationCode
  /// Get
  @override
  Future<String> getMeetingValidationCode({required int meetingId}) async {
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

  /// Digunakan untuk mengatur expired date dari tiap absen meeting
  /// https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/class-record-controller/setMeetingValidationCodeExpireDateTime
  /// Put
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

  /// Digunakan untuk memperoleh data meeting berdasarkan meeting id
  /// https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/class-record-controller/findMeeting
  /// Get
  @override
  Future<MeetingData> singleMeetingData({required int meetingId}) async {
    try {
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
    } catch (e) {
      throw ServerException();
    }
  }

  /// Get Single Meeting Attendance Statistic
  /// https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/class-record-controller/findMeetingStatistics
  /// Get
  @override
  Future<List<StatisticData>> singleMeetingAttendanceStatistic(
      {required int meetingId}) async {
    try {
      final credential = await authPreferenceHelper.getUser();

      final responseData = await client.get(
        Uri.parse(
          '${ApiService.baseUrlCPL}/class-record/meeting/${meetingId}/statistics',
        ),
        headers: {
          "Cookie": credential!.session ?? '',
        },
      );
      if (responseData.statusCode == 200) {
        Iterable dataResponse =
            DataResponse<List<dynamic>>.fromJson(jsonDecode(responseData.body))
                .data;
        return List<StatisticData>.from(
          dataResponse.map(
            (e) => StatisticData.fromJson(e),
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
}
