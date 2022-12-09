// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:e_con/core/common/auth_preference_helper.dart';
import 'package:e_con/core/common/exception.dart';
import 'package:e_con/core/responses/data_response.dart';
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
    final response = await client.post(
      Uri.parse('${ApiService.baseUrl}/users/login'),
      headers: {
        "Authorization": basicAuth,
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      final dataResponse =
          DataResponse<Map<String, dynamic>>.fromJson(jsonDecode(response.body))
              .data;
      final userCredential = UserCredential.fromJson(dataResponse);
      authPreferenceHelper.setUserData(
          userCredential.token!, userCredential.role!);
      return userCredential;
    } else if (response.statusCode == 401) {
      throw UnauthenticateException();
    } else if (response.statusCode == 404) {
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
