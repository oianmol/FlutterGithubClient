import 'package:LoginUI/ui/dashboard/DashboardPage.dart';
import 'package:LoginUI/ui/login/LoginPage.dart';
import 'package:LoginUI/ui/repolist/RepoListPage.dart';
import 'package:LoginUI/ui/searchusers/UserSearchPage.dart';
import 'package:LoginUI/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';

class DashboardPageState extends State<DashboardPage> {
  Widget appBarTitle = new Text("Your Dashboard");

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return new Scaffold(
        drawer: getDrawer(),
        body: new Stack(
          children: <Widget>[toolbarAndroid()],
        ));
  }

  toolbarAndroid() {
    return new AppBar(
      centerTitle: false,
      title: appBarTitle,
    );
  }

  getDrawer() {
    return new Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Welcome!'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('User Search'),
            onTap: () {
              navigateTo(UserSearchPage());
            },
          ),
          ListTile(
            title: Text('My Repo List'),
            onTap: () {
              navigateTo(RepoListPage());
            },
          ),
          ListTile(
            title: Text('Logout!'),
            onTap: () {
              logoutUser();
            },
          )
        ],
      ),
    );
  }

  void navigateTo(StatefulWidget statefulWidget) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => statefulWidget),
    );
  }

  void logoutUser() {
    SharedPrefs().clear().then((onClear) {
      navigateTo(LoginPage());
    });
  }
}
