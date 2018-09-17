import 'dart:convert' show utf8, base64;

class Utils {
  static String encodeCredentials(username, password) {
    final combinedStr = "$username:$password";
    return base64.encode(utf8.encode(combinedStr));
  }
}