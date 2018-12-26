import 'dart:async';
import 'dart:convert';

import 'package:LoginUI/model/ReposModel.dart';
import 'package:LoginUI/model/UserProfile.dart';
import 'package:LoginUI/network/Github.dart';
import 'package:LoginUI/ui/base/BaseStatefulState.dart';
import 'package:LoginUI/ui/dashboard/DrawerHeaderLayout.dart';
import 'package:LoginUI/userprofile/UserProfilePage.dart';
import 'package:LoginUI/utils/RepoListProvider.dart';
import 'package:LoginUI/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart';

class UserProfileState extends BaseStatefulState<UserProfilePage> {
  UserProfile user;

  String accessToken;

  StreamSubscription<Response> subscriptionRepos;

  List<ReposModel> repos;

  StreamSubscription<Response> subScriptionApiUserProfile;

  UserProfileState(@required this.user);

  int page = 1;

  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(_scrollListener);
    SharedPrefs().getToken().then((token) {
      accessToken = token;
      getUserProfile();
      getRepos();
    });
  }

  @override
  void dispose() {
    if (subscriptionRepos != null) {
      subscriptionRepos.cancel();
    }
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    print(scrollController.position.extentAfter);
    if (scrollController.position.extentAfter == 0 && repos != null) {
      if (subscriptionRepos == null) {
        getRepos();
      }
    }
  }

  @override
  Widget prepareWidget(BuildContext context) {
    var uiElements = <Widget>[];
    uiElements.add(header());
    uiElements.add(new Expanded(
        child: RepoListProvider.getReposList(repos, false, scrollController)));

    return new Scaffold(
      key: scaffoldKey,
      appBar: toolbarAndroid(),
      body: new Column(
        children: uiElements,
      ),
    );
  }

  toolbarAndroid() {
    return new AppBar(
      centerTitle: false,
      backgroundColor: Colors.black,
      title: new Text(
        user.login,
        textDirection: TextDirection.ltr,
      ),
    );
  }

  header() {
    return new DrawerHeaderLayout(userProfile: user);
  }

  getRepos() {
    if (subscriptionRepos != null) {
      subscriptionRepos.cancel();
    }
    showProgress();

    subscriptionRepos = RepoListProvider.getUserRepos(
        page, 10, accessToken, user.login, (repos) {
      this.setState(() {
        if (this.repos == null) {
          this.repos = repos;
        } else {
          this.repos.addAll(repos);
        }
      });
      page = page + 1;
      hideProgress();
      subscriptionRepos = null;
    });
  }

  void getUserProfile() {
    hideProgress();
    if (subScriptionApiUserProfile != null) {
      subScriptionApiUserProfile.cancel();
    }
    showProgress();

    var getUserProfile = Github.getUserProfile(user.login).asStream();
    subScriptionApiUserProfile = getUserProfile.listen((response) {
      this.setState(() {
        this.user = UserProfile.fromJson(json.decode(response.body));
      });
      hideProgress();
    });
  }
}
