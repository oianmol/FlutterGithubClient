import 'dart:async';
import 'dart:convert';

import 'package:LoginUI/model/UserProfile.dart';
import 'package:LoginUI/network/Github.dart';
import 'package:LoginUI/ui/base/BaseStatefulState.dart';
import 'package:LoginUI/ui/dashboard/DrawerHeaderLayout.dart';
import 'package:LoginUI/utils/RepoListProvider.dart';
import 'package:LoginUI/userprofile/UserProfilePage.dart';
import 'package:LoginUI/utils/SharedPrefs.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UserProfileState extends BaseStatefulState<UserProfilePage> {

  final UserProfile user;

  String accessToken;

  StreamSubscription<Response> subscriptionRepos;
  RepoListProvider repoListProvider;

  var repos;


  UserProfileState(@required this.user);


  @override
  void initState() {
    super.initState();
    repoListProvider = new RepoListProvider();
    SharedPrefs().getToken().then((token) {
      accessToken = token;
      print(user);
      getRepos();
    });
  }

  @override
  Widget prepareWidget(BuildContext context) {
    var uiElements = <Widget>[];
    uiElements.add(header());
    uiElements.add(new Expanded(child: repoListProvider.getReposList(repos,false)));

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

    subscriptionRepos = repoListProvider.getUserRepos(accessToken,user.login,(repos){
      this.setState(() {
        this.repos = repos;
      });
      hideProgress();
    });

  }
}
