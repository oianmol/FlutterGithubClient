import 'dart:async';
import 'dart:io';
import 'package:LoginUI/ui/Utils.dart';

import 'package:http/http.dart' as http;

class Apis {
  static Future<http.Response> fetchCurrentUser(var username, var password) {
    var encodedCreds = Utils.encodeCredentials(username, password);
    var authHeaderValue = "Basic $encodedCreds";
    return http.get("https://api.github.com/user", headers: {HttpHeaders.authorizationHeader: authHeaderValue});
  }

  static Future<http.Response> fetchPost() {
    return http.get('https://jsonplaceholder.typicode.com/posts/1');
  }

}

