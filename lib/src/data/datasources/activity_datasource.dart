import 'dart:convert';

import 'package:e_con/core/helpers/auth_preference_helper.dart';
import 'package:e_con/core/responses/data_response.dart';
import 'package:e_con/core/services/api_service.dart';
import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/src/data/models/cpl_lecturer/meeting_data.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

abstract class ActivityDataSource {
  Future<List<MeetingData>?> fetchAllMeetingByDate({required DateTime? date});
}

class ActivityDataSourceImpl implements ActivityDataSource {
  final http.Client client;
  final AuthPreferenceHelper authPreferenceHelper;

  ActivityDataSourceImpl(
      {required this.client, required this.authPreferenceHelper});

  /// Digunakan untuk mendapatkan list meeting berdasarkan date
  ///  https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/class-record-controller/findMeetingByDate
  /// Get
  @override
  Future<List<MeetingData>?> fetchAllMeetingByDate({DateTime? date}) async {
    try {
      final credential = await authPreferenceHelper.getUser();

      final uri =
          Uri.parse('${ApiService.baseUrlCPL}/class-record/meeting/all-by-date')
              .replace(queryParameters: {
        'date': DateFormat('dd.MM.yyyy').format(date ?? DateTime.now()),
      });

      final responseData = await client.get(
        uri,
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
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException();
    }
  }
}
