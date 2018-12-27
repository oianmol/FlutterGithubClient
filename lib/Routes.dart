import 'package:LoginUI/ui/dashboard/DashboardPage.dart';
import 'package:LoginUI/ui/login/LoginPage.dart';
import 'package:LoginUI/ui/repodetails/RepoDetailsPage.dart';
import 'package:LoginUI/ui/repolist/RepoListPage.dart';
import 'package:LoginUI/ui/searchusers/UserSearchPage.dart';
import 'package:LoginUI/ui/usergists/UserGistsPage.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static String root = "/";
  static String login = "/login";
  static String loginDashboard = "/dashboard";
  static String dashboardRepoList = "/repolist";
  static String dashboardUserSearch = "/usersearch";
  static String repoDetails = "/repolist/:loginname/:repo";
  static String userGists = "/users/:loginname/gists";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
    });
    router.define(root, handler: loginHandler);
    router.define(login, handler: loginHandler);
    router.define(loginDashboard, handler: loginDashHandler);
    router.define(dashboardRepoList, handler: dashboardRepoListHandler);
    router.define(dashboardUserSearch, handler: dashboardUserSearchHandler);
    router.define(repoDetails, handler: repoDetailsHandler);
    router.define(userGists, handler: userGistsHandler);
  }
}

var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new LoginPage();
});

var loginDashHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new DashboardPage();
});

var dashboardRepoListHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new RepoListPage();
});

var dashboardUserSearchHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new UserSearchPage();
});

var repoDetailsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new RepoDetailsPage(params["loginname"][0],params["repo"][0]);
    });

var userGistsHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new UserGistsPage(params["loginname"][0]);
    });
