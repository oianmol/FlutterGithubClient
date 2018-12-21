import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:LoginUI/ui/AppConstants.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class Github {
  static String authorizeURL = "https://github.com/login/oauth/authorize";
  static String accessTokenURL = "https://github.com/login/oauth/access_token";
  static String authorizeBasicUrl = "https://api.github.com/authorizations";
  static String getUserGithub = "https://api.github.com/search/users";
  static String getMyUserGithub = "https://api.github.com/user";
  static String getMyReposGithub = "https://api.github.com/user/repos";
  static String getUsersReposGithub = "https://api.github.com/users/:username/repos";

  static String clientId =
      "client_id"; //Required. The client ID you received from GitHub when you registered.
  static String clientSecret =
      "client_secret"; //Required. The client secret you received from GitHub for your GitHub App.
  static String redirectUri =
      "redirect_uri"; //The URL in your application where users will be sent after authorization. See details below about redirect urls.
  static String scope =
      "scope"; //A space-delimited list of scopes. If not provided, scope defaults to an empty list for users that have not authorized any scopes for the application. For users who have authorized scopes for the application, the user won't be shown the OAuth authorization page with the list of scopes. Instead, this step of the flow will automatically complete with the set of scopes the user has authorized for the application. For example, if a user has already performed the web flow twice and has authorized one token with user scope and another token with repo scope, a third web flow that does not provide a scope will receive a token with user and repo scope.
  static String state =
      "state"; //An unguessable random string. It is used to protect against cross-site request forgery attacks.
  static String allowSignup =
      "allow_signup"; //Whether or not unauthenticated users will be offered an option to sign up for GitHub during the OAuth flow. The default is true. Use false in the case that a policy prohibits signups.

  static String affiliationParamRepoSearch =
      "&visibility=all&affiliation=owner,collaborator,organization_member";

  static Future<http.Response> authorize(Map<String, String> requestData) {
    return http.get(authorizeURL, headers: requestData);
  }

  static Map<String, String> getGithubHeaders() {
    Map<String, String> headers = new Map();
    headers.putIfAbsent(Github.clientId, () {
      return AppConstants.GITHUB_CLIENT_ID;
    });
    headers.putIfAbsent(Github.redirectUri, () {
      return AppConstants.GITHUB_CALLBACK_URL;
    });
    headers.putIfAbsent(Github.scope, () {
      return "repo,user";
    });
    headers.putIfAbsent(Github.state, () {
      return AppConstants.GITHUB_CLIENT_ID;
    });
    headers.putIfAbsent(Github.allowSignup, () {
      return "true";
    });
    return headers;
  } //https://github.com/login/oauth/authorize?client_id=5eebe59bc6ed95a4f4b1&redirect_uri	=http://localhost:8080/&scope=repo,user&state=5eebe59bc6ed95a4f4b1&allow_signup=true&

  static Future<Stream<String>> _server() async {
    final StreamController<String> onCode = new StreamController();
    HttpServer server =
        await HttpServer.bind(InternetAddress.loopbackIPv4, 8080, shared: true);
    server.listen((HttpRequest request) async {
      final String code = request.uri.queryParameters["code"];
      request.response
        ..statusCode = 200
        ..headers.set("Content-Type", ContentType.html.mimeType)
        ..write("<html><h1>You can now close this window</h1></html>");
      await request.response.close();
      await server.close(force: true);
      onCode.add(code);
      await onCode.close();
    });
    return onCode.stream;
  }

  static String githubAuthUrl() {
    StringBuffer buffer = new StringBuffer();
    buffer.write(Github.authorizeURL);
    buffer.write("?");
    getGithubHeaders().forEach((key, value) {
      buffer.write(key);
      buffer.write("=");
      buffer.write(value);
      buffer.write("&");
    });
    return buffer.toString();
  }

  static Future<String> authenticate(Null Function(String) param0) async {
    Stream<String> onToken = await _server();

    String url = Github.githubAuthUrl().replaceAll(" ", "");
    print(url);
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      param0("");
      throw 'Could not launch $url';
    }

    final String token = await onToken.first;
    print("Received token " + token);

    Github.postAccessToken(token).then((response) {
      print("Response status: ${response}");
      param0(response);
    }).catchError((error) {
      param0("Error body: $error");
    }).whenComplete(() {});

    return token;
  }

  static Future<String> postAccessToken(String code) async {
    HttpClient httpClient = new HttpClient();
    Map map = {
      clientId: AppConstants.GITHUB_CLIENT_ID,
      clientSecret: AppConstants.GITHUB_CLIENT_SECRET,
      'code': code,
    };

    HttpClientRequest request =
        await httpClient.postUrl(Uri.parse(accessTokenURL));
    request.headers.set('content-type', 'application/json');
    request.write(json.encode(map));
    print(request.headers);
    print(request.encoding.name);
    print(request.uri.toString());
    print(json.encode(map));
    HttpClientResponse response = await request.close();
    print(response.statusCode);
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return reply;
  }

  static Future<http.Response> getUsersBySearch(String response, String value) {
    String fullUrl = getUserGithub + "?" + response + "&q=" + value;
    print(fullUrl);
    return http.get(fullUrl);
  }

  static Future<http.Response> getMyUserProfile(String accessToken){
    String fullUrl = getMyUserGithub + "?access_token=" + accessToken;
    print(fullUrl);
    return http.get(fullUrl);
  }

  static Future<http.Response> getAllMyRepos(String accessToken) {
    String fullUrl =
        getMyReposGithub + "?" + accessToken + affiliationParamRepoSearch;
    print(fullUrl);
    return http.get(fullUrl);
  }


  static Future<http.Response> getUserRepos(String accessToken,String userName) {
    String fullUrl =
        getUsersReposGithub.replaceAll(":username", userName) + "?" + accessToken + affiliationParamRepoSearch+"&"+"type=all";
    print(fullUrl);
    return http.get(fullUrl);
  }





  static Future<http.Response> getFromUrl(String reposUrl, String accessToken) {
    String fullUrl = reposUrl + "?access_token=" + accessToken + affiliationParamRepoSearch;
    print(fullUrl);
    return http.get(fullUrl);
  }

  static Future<http.Response> authenticateUsernamePassword(
      String username, String password) async {
    var value = base64Encode(utf8.encode('$username:$password'));
    var authrorization = 'Basic $value';
    print(authrorization);
    print(authorizeBasicUrl);
    var list = List<String>();
    list.add("user");
    list.add("repo");
    list.add("gist");
    list.add("notifications");
    list.add("read:org");

    Map map = {
      clientId: AppConstants.GITHUB_CLIENT_ID,
      "scopes": list,
      clientSecret: AppConstants.GITHUB_CLIENT_SECRET,
    };
    print(map);
    return http.post(authorizeBasicUrl,
        headers: {'Authorization': authrorization}, body: json.encode(map));
  }
}
