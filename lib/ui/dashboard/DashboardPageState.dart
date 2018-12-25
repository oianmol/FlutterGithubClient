import 'dart:async';

import 'package:LoginUI/Routes.dart';
import 'package:LoginUI/main.dart';
import 'package:LoginUI/model/UserProfile.dart';
import 'package:LoginUI/network/Github.dart';
import 'package:LoginUI/ui/base/BaseStatefulState.dart';
import 'package:LoginUI/ui/dashboard/DashboardPage.dart';
import 'package:LoginUI/ui/dashboard/DrawerHeaderLayout.dart';
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

  RepoListProvider repoListProvider;

  var starredRepos;

  var myRepos;

  var toolbar = GlobalKey(debugLabel: "toolbar");


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
      userDashboardTitle = "${currentUserProfile.name}'s Dashboard";
    } else {
      userDashboardTitle = "Dashboard";
    }
    return new AppBar(
      key: toolbar,
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
          new DrawerHeaderLayout(userProfile: currentUserProfile),
          ListTile(
            title: Text('User Search'),
            onTap: () {
              navigateTo(Routes.dashboardUserSearch);
            },
          ),
          ListTile(
            title: Text('My Repo List'),
            onTap: () {
              navigateTo(Routes.dashboardRepoList);
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
    var uiElements = <Widget>[];
    uiElements.add(new Container(height: kToolbarHeight + 20,));
    uiElements.add(getCardMyView(starredRepos,"Starred Repos"));
    uiElements.add(getCardMyView(myRepos,"Repositories"));

    return new Scaffold(
        key: scaffoldKey,
        drawer: getDrawer(),
        body: new Stack(children: <Widget>[toolbarAndroid(),new CustomScrollView(
          slivers: [
            new SliverList(
              delegate: new SliverChildListDelegate(
                uiElements,
              ),
            ),
          ],
        )],));
  }

  void getMyUserProfile() {
    var stream = SharedPrefs().getCurrentUserProfile().asStream();
    if (subscriptionMyProfile != null) {
      subscriptionMyProfile.cancel();
    }
    subscriptionMyProfile = stream.listen((profile) {
      if (profile != null) {
        this.setState(() {
          currentUserProfile =  profile;
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
        repoListProvider.getStarredRepos(currentUserProfile.login, (repos) {
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
    subMyRepos =
        repoListProvider.getMyRepos(accessToken, (repos) {
          this.setState(() {
            this.myRepos = repos;
          });
          hideProgress();
        });
  }

  Widget getCardMyView(var repos,String title) {
    return new Center(
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 4,
        child: new Column(
            children: repoListProvider.reposList(repos, title)),
      ),
    );
  }
}
