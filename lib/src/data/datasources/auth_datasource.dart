// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:e_con/core/common/exception.dart';
import 'package:e_con/core/responses/data_response.dart';
import 'package:e_con/core/services/api_service.dart';
import 'package:e_con/src/data/models/user_credential.dart';
import 'package:http/http.dart' as http;

abstract class AuthDataSource {
  Future<UserCredential> signIn(String username, String password);
}

class AuthDataSourceImpl implements AuthDataSource {
  final http.Client client;

  AuthDataSourceImpl({required this.client});

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
      final dataResponse =
          DataResponse<Map<String, dynamic>>.fromJson(jsonDecode(response.body))
              .data;
      return UserCredential.fromJson(dataResponse);
    } else {
      throw AuthException();
    }
  }
}
