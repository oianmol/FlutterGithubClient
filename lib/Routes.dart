import 'package:LoginUI/ui/dashboard/DashboardPage.dart';
import 'package:LoginUI/ui/login/LoginPage.dart';
import 'package:LoginUI/ui/repolist/RepoListPage.dart';
import 'package:LoginUI/ui/searchusers/UserSearchPage.dart';
import 'ui/notifications/NotificationsPage.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static String root = "/";
  static String login = "/login";
  static String loginDashboard = "/dashboard";
  static String dashboardRepoList = "/dashboard/repolist";
  static String dashboardUserSearch = "/dashboard/usersearch";
  static String notificationsList = "/dashboard/notifications";

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
    router.define(notificationsList, handler: notificationsHandler);
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

var notificationsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new NotificationsPage();
    }
);
