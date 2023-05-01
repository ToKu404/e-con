// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:e_con/core/helpers/auth_preference_helper.dart';
import 'package:e_con/core/helpers/notif_helper.dart';
import 'package:e_con/core/utils/exception.dart';
import 'package:e_con/core/responses/data_response.dart';
import 'package:e_con/core/responses/session.dart';
import 'package:e_con/core/services/api_service.dart';
import 'package:e_con/src/data/models/user/user_credential.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

abstract class AuthDataSource {
  Future<UserCredential> signIn(String username, String password);
  Future<UserCredential?> getUser();
  Future<bool> logOut();
  Future<Map<String, String>> getCredential();
}

class AuthDataSourceImpl implements AuthDataSource {
  final http.Client client;
  final AuthPreferenceHelper authPreferenceHelper;
  final NotifHelper notifHelper;

  AuthDataSourceImpl(
      {required this.client,
      required this.authPreferenceHelper,
      required this.notifHelper});

  /// Digunakan untuk login ke CPL dan Tugas Akhir
  /// Cpl :  https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/auth-controller/login
  /// Tugas Akhir : https://api.sifa.npedigihouse.tech/docs/#/default/post_api_v0_users_login
  /// POST
  @override
  Future<UserCredential> signIn(String u, String password) async {
    try {
      String username = u.trim();

      await authPreferenceHelper.removeUserData();

      final userNotifId = await notifHelper.generateUserAppId();

      final map = {
        'playerID': userNotifId,
      };

      final String basicAuth =
          'Basic ${base64.encode(utf8.encode('$username:$password'))}';
      final responseFE = await client.post(
        Uri.parse('${ApiService.baseUrlFinalExam}/users/login'),
        headers: {
          "Authorization": basicAuth,
          'Content-Type': 'application/json',
        },
        body: json.encode(map),
      );

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
        if (userCredential.role!.id != 4 && userCredential.role!.id != 5) {
          throw UnauthenticateException();
        }
        authPreferenceHelper.setUserData(userCredential, username, password);
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

  /// Digunakan untuk mengambil usercredential dan melakukan pengecekan expired token dan session
  /// CPL :  https://api.cpl.npedigihouse.tech/api/swagger-ui/index.html#/auth-controller/getCredential
  /// Tugas Akhir Dosen : https://api.sifa.npedigihouse.tech/docs/#/default/get_api_v0_lecturers__nim_
  /// Tugas Akhir Mahasiswa : https://api.sifa.npedigihouse.tech/docs/#/default/get_api_v0_students__nim_
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
        if (credential.role!.id == 4) {
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
          // instance notif;
          await notifHelper.init();
          return credential;
        } else if (responseData.statusCode == 401 ||
            response.statusCode == 401) {
          logOut();
          return null;
        } else {
          throw UnauthenticateException();
        }
      } else {
        return null;
      }
    } catch (e) {
      throw ServerException();
    }
  }

  /// Digunakan untuk logout dengan menghapus credential di sharedpreferences
  @override
  Future<bool> logOut() async {
    try {
      final credential = await authPreferenceHelper.getUser();
      if (credential != null) {
        await client.get(
          Uri.parse('${ApiService.baseUrlFinalExam}/users/logout'),
          headers: {
            "Authorization": "Bearer ${credential.token}",
          },
        );
        await authPreferenceHelper.removeUserData();
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Map<String, String>> getCredential() async {
    try {
      final credential = await authPreferenceHelper.getCredential();
      return credential;
    } catch (e) {
      throw LocalDatabaseException();
    }
  }
}
