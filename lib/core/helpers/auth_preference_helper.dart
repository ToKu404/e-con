import 'package:e_con/src/data/models/user/user_credential.dart';
import 'package:e_con/src/data/models/user/helper/user_role_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Auth Preferences Helper
/// Save auth session and token on shared prefrences
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

  // Key
  static const userTokenKey = 'USER_TOKEN';
  static const userSessionKey = 'USER_SESSION';
  static const userRoleKey = 'USER_ROLE';

  /// For Save User Credential Data
  Future<bool> setUserData(UserCredential user) async {
    final pr = await preferences;
    try {
      pr!.setString(userTokenKey, user.token ?? '');
      pr.setString(userSessionKey, user.session ?? '');
      pr.setInt(userRoleKey, user.role == UserRole.student ? 7 : 6);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// For Get Use Credential Data
  Future<UserCredential?> getUser() async {
    final pr = await preferences;
    if (pr!.containsKey(userTokenKey)) {
      String? token = pr.getString(userTokenKey);
      String? session = pr.getString(userSessionKey);
      UserRole role =
          pr.getInt(userRoleKey) == 7 ? UserRole.student : UserRole.teacher;

      return UserCredential(role: role, token: token, session: session);
    } else {
      return null;
    }
  }

  /// For Delete User Credential Data
  Future<bool> removeUserData() async {
    final pr = await preferences;
    try {
      pr!.remove(userTokenKey);
      pr.remove(userSessionKey);
      pr.remove(userRoleKey);

      return true;
    } catch (e) {
      return false;
    }
  }
}
