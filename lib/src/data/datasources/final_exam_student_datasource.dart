import 'dart:convert';

import 'package:e_con/core/helpers/auth_preference_helper.dart';
import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/core/responses/data_response.dart';
import 'package:e_con/core/services/api_service.dart';
import 'package:e_con/src/data/models/final_exam/seminar_data.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

abstract class FinalExamStudentDataSource {
  Future<SeminarData?> getDetailSeminarByStudent();
}

class FinalExamStudentDataSourceImpl implements FinalExamStudentDataSource {
  final http.Client client;
  final AuthPreferenceHelper authPreferenceHelper;

  FinalExamStudentDataSourceImpl(
      {required this.client, required this.authPreferenceHelper});

  /// Get Detail Seminar By Dosen
  /// https://api.sifa.npedigihouse.tech/docs/#/default/get_api_v0_students__nim__seminars__seminarID_
  @override
  Future<SeminarData?> getDetailSeminarByStudent() async {
    try {
      final credential = await authPreferenceHelper.getUser();
      Map<String, dynamic> payload = Jwt.parseJwt(credential!.token!);

      final responseData = await client.get(
        Uri.parse(
          '${ApiService.baseUrlFinalExam}/students/${payload['username']}/seminars/invited/${1}',
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
        return null;
      } else {
        throw ServerException();
      }
    } catch (e) {
      print(e.toString());
      throw ServerException();
    }
  }
}
