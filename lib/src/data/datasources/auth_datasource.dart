// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:e_con/core/common/auth_preference_helper.dart';
import 'package:e_con/core/common/exception.dart';
import 'package:e_con/core/responses/data_response.dart';
import 'package:e_con/core/responses/session.dart';
import 'package:e_con/core/services/api_service.dart';
import 'package:e_con/src/data/models/user/user_credential.dart';
import 'package:http/http.dart' as http;

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
    final String basicAuth =
        'Basic ${base64.encode(utf8.encode('$username:$password'))}';

    final responseFE = await client.post(
      Uri.parse('${ApiService.baseUrlFinalExam}/users/login'),
      headers: {
        "Authorization": basicAuth,
      },
    );

    final responseCPL = await client.post(
      Uri.parse('${ApiService.baseUrlCPL}/login'),
      headers: {
        "Authorization": basicAuth,
      },
    );

    String? cookie = Session.getCookie(responseCPL.headers);

    print(responseCPL.statusCode);
    print(responseFE.statusCode);

    if (responseFE.statusCode == 200 && responseCPL.statusCode == 200) {
      print(responseFE.body);
      final dataResponse = DataResponse<Map<String, dynamic>>.fromJson(
              jsonDecode(responseFE.body))
          .data;
      final userCredential =
          UserCredential.fromJson(dataResponse, cookie ?? '');
      authPreferenceHelper.setUserData(
          userCredential.token!, userCredential.token!, userCredential.role!);
      return userCredential;
    } else if (responseFE.statusCode == 401 && responseCPL.statusCode == 401) {
      throw UnauthenticateException();
    } else if (responseFE.statusCode == 404 && responseCPL.statusCode == 404) {
      throw UserNotFoundException();
    } else {
      throw AuthException();
    }
  }

  @override
  Future<UserCredential?> getUser() {
    try {
      return authPreferenceHelper.getUser();
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
