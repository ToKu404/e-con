
/// get cookie from header
class Session {
  static String? getCookie(Map<String, String> headers) {
    String? rawCookie = headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      String cookie = (index == -1) ? rawCookie : rawCookie.substring(0, index);
      return cookie;
    }
    return null;
  }
}
