// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:e_con/core/helpers/auth_preference_helper.dart';
import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/core/responses/data_response.dart';
import 'package:e_con/core/responses/session.dart';
import 'package:e_con/core/services/api_service.dart';
import 'package:e_con/src/data/models/user/helper/user_role_type.dart';
import 'package:e_con/src/data/models/user/user_credential.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

abstract class AuthDataSource {
  Future<UserCredential> signIn(String username, String password);
  Future<UserCredential?> getUser();
  Future<bool> logOut();
}

class AuthDataSourceImpl implements AuthDataSource {
  final http.Client client;
  final AuthPreferenceHelper authPreferenceHelper;

  AuthDataSourceImpl(
      {required this.client, required this.authPreferenceHelper});

  @override
  Future<UserCredential> signIn(String username, String password) async {
    try {
      final String basicAuth =
          'Basic ${base64.encode(utf8.encode('$username:$password'))}';

      final responseFE = await client.post(
        Uri.parse('${ApiService.baseUrlFinalExam}/users/login'),
        headers: {
          "Authorization": basicAuth,
        },
      );

      print(responseFE.body);

      final responseCPL = await client.post(
        Uri.parse('${ApiService.baseUrlCPL}/login'),
        headers: {
          "Authorization": basicAuth,
        },
      );

      String? cookie = Session.getCookie(responseCPL.headers);

      if (responseFE.statusCode == 200 && responseCPL.statusCode == 200) {
        final dataResponse = DataResponse<Map<String, dynamic>>.fromJson(
                jsonDecode(responseFE.body))
            .data;

        final userCredential = UserCredential.fromJson(
          dataResponse,
          cookie ?? '',
        );
        authPreferenceHelper.setUserData(userCredential);
        return userCredential;
      } else if (responseFE.statusCode == 401 &&
          responseCPL.statusCode == 401) {
        throw UnauthenticateException();
      } else if (responseFE.statusCode == 404 &&
          responseCPL.statusCode == 404) {
        throw UserNotFoundException();
      } else {
        throw AuthException();
      }
    } catch (e) {
      throw AuthException();
    }
  }

  @override
  Future<UserCredential?> getUser() async {
    try {
      final credential = await authPreferenceHelper.getUser();
      if (credential != null) {
        final responseData = await client.get(
          Uri.parse('${ApiService.baseUrlCPL}/credential'),
          headers: {
            "Cookie": credential.session ?? '',
          },
        );
        Map<String, dynamic> payload = Jwt.parseJwt(credential.token!);

        late dynamic response;
        if (credential.role == UserRole.teacher) {
          response = await client.get(
            Uri.parse(
                '${ApiService.baseUrlFinalExam}/lecturers/${payload['username']}'),
            headers: {
              "Authorization": "Bearer ${credential.token}",
            },
          );
        } else {
          response = await client.get(
            Uri.parse(
                '${ApiService.baseUrlFinalExam}/students/${payload['username']}'),
            headers: {
              "Authorization": "Bearer ${credential.token}",
            },
          );
        }

        if (responseData.statusCode == 200 && response.statusCode == 200) {
          return credential;
        } else {
          throw UnauthenticateException();
        }
      } else {
        return null;
      }
    } catch (e) {
      throw LocalDatabaseException();
    }
  }

  @override
  Future<bool> logOut() {
    try {
      return authPreferenceHelper.removeUserData();
    } catch (e) {
      throw LocalDatabaseException();
    }
  }
}
