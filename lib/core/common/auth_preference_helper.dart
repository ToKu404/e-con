import 'package:e_con/src/data/models/user/user_credential.dart';
import 'package:e_con/src/data/models/user/user_role.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPreferenceHelper {
  static AuthPreferenceHelper? _preferenceHelper;
  AuthPreferenceHelper._instance() {
    _preferenceHelper = this;
  }
  static SharedPreferences? _preferences;

  Future<SharedPreferences?> get preferences async {
    _preferences ??= await _initPreference();
    return _preferences;
  }

  factory AuthPreferenceHelper() =>
      _preferenceHelper ?? AuthPreferenceHelper._instance();

  static SharedPreferences? sharedPreferences;

  Future<SharedPreferences> _initPreference() async {
    final pr = await SharedPreferences.getInstance();
    return pr;
  }

  static const userTokenKey = 'USER_TOKEN';
  static const userRoleKey = 'USER_ROLE';

  Future<bool> isUserTokenExist() async {
    final pr = await preferences;
    return pr!.containsKey(userTokenKey) ? true : false;
  }

  Future<bool> setUserData(String userToken, UserRole userRole) async {
    final pr = await preferences;
    try {
      pr!.setString(userTokenKey, userToken);
      pr.setInt(userRoleKey, userRole == UserRole.student ? 7 : 6);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<UserCredential?> getUser() async {
    final pr = await preferences;
    if (pr!.containsKey(userTokenKey)) {
      String? token = pr.getString(userTokenKey);
      UserRole role =
          pr.getInt(userRoleKey) == 7 ? UserRole.student : UserRole.teacher;
      return UserCredential(role: role, token: token);
    } else {
      return null;
    }
  }

  Future<bool> removeUserData() async {
    final pr = await preferences;
    try {
      pr!.remove(userTokenKey);
      pr.remove(userRoleKey);
      return true;
    } catch (e) {
      return false;
    }
  }
}
