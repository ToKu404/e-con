import 'dart:convert';

import 'package:e_con/core/helpers/auth_preference_helper.dart';
import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/core/responses/data_response.dart';
import 'package:e_con/core/services/api_service.dart';
import 'package:e_con/src/data/models/final_exam/seminar_data.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

abstract class FinalExamLecturerDataSource {
  Future<List<SeminarData>> getInvitedSeminars();
  Future<SeminarData> getDetailSeminar(int seminarId);
}

class FinalExamLecturerDataSourceImpl implements FinalExamLecturerDataSource {
  final http.Client client;
  final AuthPreferenceHelper authPreferenceHelper;

  FinalExamLecturerDataSourceImpl(
      {required this.client, required this.authPreferenceHelper});

  /// Get List Seminars By Dosen
  /// https://api.sifa.npedigihouse.tech/docs/#/default/get_api_v0_lecturers__nim__seminars_invited
  /// Get
  @override
  Future<List<SeminarData>> getInvitedSeminars() async {
    try {
      final credential = await authPreferenceHelper.getUser();
      Map<String, dynamic> payload = Jwt.parseJwt(credential!.token!);

      final responseData = await client.get(
        Uri.parse(
          '${ApiService.baseUrlFinalExam}/lecturers/${payload['username']}/seminars/invited',
        ),
        headers: {
          "Authorization": "Bearer ${credential.token}",
        },
      );
      if (responseData.statusCode == 200) {
        Iterable dataResponse =
            DataResponse<List<dynamic>>.fromJson(jsonDecode(responseData.body))
                .data;
        return List<SeminarData>.from(
          dataResponse.map(
            (e) => SeminarData.fromJson(e),
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

  /// Get Detail Seminar By Dosen
  /// https://api.sifa.npedigihouse.tech/docs/#/default/get_api_v0_lecturers__nim__seminars_invited__seminarID_
  @override
  Future<SeminarData> getDetailSeminar(int seminarId) async {
    try {
      final credential = await authPreferenceHelper.getUser();
      Map<String, dynamic> payload = Jwt.parseJwt(credential!.token!);

      final responseData = await client.get(
        Uri.parse(
          '${ApiService.baseUrlFinalExam}/lecturers/${payload['username']}/seminars/invited/${seminarId}',
        ),
        headers: {
          "Authorization": "Bearer ${credential.token}",
        },
      );
      if (responseData.statusCode == 200) {
        final dataResponse = DataResponse<Map<String, dynamic>>.fromJson(
                jsonDecode(responseData.body))
            .data;

        final seminarData = SeminarData.fromJson(dataResponse);
        return seminarData;
      } else if (responseData.statusCode == 404) {
        throw DataNotFoundException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      throw ServerException();
    }
  }
}
