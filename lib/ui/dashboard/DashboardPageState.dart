import 'dart:async';

import 'package:LoginUI/Routes.dart';
import 'package:LoginUI/main.dart';
import 'package:LoginUI/model/ReposModel.dart';
import 'package:LoginUI/model/UserProfile.dart';
import 'package:LoginUI/network/Github.dart';
import 'package:LoginUI/ui/base/BaseStatefulState.dart';
import 'package:LoginUI/ui/dashboard/DashboardPage.dart';
import 'package:LoginUI/userprofile/UserProfileHeader.dart';
import 'package:LoginUI/userprofile/UserProfileHeaderState.dart';
import 'package:LoginUI/utils/RepoListProvider.dart';
import 'package:LoginUI/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:http/src/response.dart';

class DashboardPageState extends BaseStatefulState<DashboardPage> {
  UserProfile currentUserProfile;
  String accessToken;
  StreamSubscription<UserProfile> subscriptionMyProfile;
  StreamSubscription<Response> subScriptionApiUserProfile;
  StreamSubscription<Response> subStarredRepos;
  StreamSubscription subMyRepos;

  List<ReposModel> starredRepos;
  List<ReposModel> myRepos;

  var toolbar = GlobalKey(debugLabel: "toolbar");

  RepoListProvider repoListProvider;

  @override
  void initState() {
    super.initState();
    repoListProvider = new RepoListProvider();
    SharedPrefs().getToken().then((token) {
      accessToken = token;
      getMyUserProfile();
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscriptionMyProfile?.cancel();
    subScriptionApiUserProfile?.cancel();
  }

  toolbarAndroid() {
    var userDashboardTitle;
    if (currentUserProfile != null) {
      userDashboardTitle = "${currentUserProfile.getName()}'s Dashboard";
    } else {
      userDashboardTitle = "Dashboard";
    }
    return new AppBar(
      key: toolbar,
      backgroundColor: Colors.black,
      centerTitle: false,
      title: new Text(userDashboardTitle),
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
          currentUserProfile == null?null: new UserProfileHeader(currentUserProfile),
          ListTile(
            title: Text('User Search'),
            onTap: () {
              Navigator.pop(context);
              navigateTo(Routes.dashboardUserSearch);
            },
          ),
          Divider(color: Colors.grey,),
          ListTile(
            title: Text("Notifications"),
            onTap: () {
              Navigator.pop(context);
              navigateTo(Routes.notificationsList);
            },
          ),
          new Divider(color: Colors.grey,),
          ListTile(
            title: Text('My Repo List'),
            onTap: () {
              Navigator.pop(context);
              navigateTo(Routes.dashboardRepoList);
            },
          ),
          new Divider(color: Colors.grey,),
          ListTile(
            title: Text('Logout!'),
            onTap: () {
              Navigator.pop(context);
              logoutUser();
            },
          ),
          new Divider(color: Colors.grey,)
        ],
      ),
    );
  }

  void navigateTo(String name) {
    Application.router.navigateTo(context, name);
  }

  void logoutUser() {
    SharedPrefs().clear().then((onClear) {
      Application.router.navigateTo(context, Routes.login, clearStack: true);
    });
  }

  @override
  Widget prepareWidget(BuildContext context) {
    var uiElements = <Widget>[toolbarAndroid()];
    uiElements.add(getCardMyView(starredRepos, "Starred Repos"));
    uiElements.add(getCardMyView(myRepos, "Repositories"));

    return new Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black87,
        drawer: getDrawer(),
        body: new CustomScrollView(
          slivers: [
            new SliverList(
              delegate: new SliverChildListDelegate(
                uiElements,
              ),
            ),
          ],
        ));
  }

  void getMyUserProfile() {
    var stream = SharedPrefs().getCurrentUserProfile().asStream();
    if (subscriptionMyProfile != null) {
      subscriptionMyProfile.cancel();
    }
    subscriptionMyProfile = stream.listen((profile) {
      if (profile != null) {
        this.setState(() {
          currentUserProfile = profile;
          getMyStarredRepos();
        });
      } else {
        getApiUserProfile();
      }
    });
  }

  void getApiUserProfile() {
    hideProgress();
    if (subScriptionApiUserProfile != null) {
      subScriptionApiUserProfile.cancel();
    }
    showProgress();

    var getUserProfile = Github.getMyUserProfile(accessToken).asStream();
    subScriptionApiUserProfile = getUserProfile.listen((response) {
      SharedPrefs().saveCurrentUserProfile(response.body);
      this.setState(() {
        getMyUserProfile();
      });
      hideProgress();
    });
  }

  void getMyStarredRepos() {
    showProgress();
    if (subStarredRepos != null) {
      subStarredRepos.cancel();
    }
    subStarredRepos =
        repoListProvider.getStarredRepos(5, currentUserProfile.login, (repos) {
      this.setState(() {
        this.starredRepos = repos;
      });
      hideProgress();
      getMyRepos();
    });
  }

  void getMyRepos() {
    showProgress();
    if (subMyRepos != null) {
      subMyRepos.cancel();
    }
    subMyRepos = repoListProvider.getMyRepos(1, 5, accessToken, (repos) {
      this.setState(() {
        this.myRepos = repos;
      });
      hideProgress();
    });
  }

  Widget getCardMyView(var repos, String title) {
    return new Center(
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 4,
        child: new Column(children: repoListProvider.reposList(repos, title)),
      ),
    );
  }
}
