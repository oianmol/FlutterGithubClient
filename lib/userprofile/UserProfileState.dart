import 'dart:async';
import 'dart:convert';

import 'package:LoginUI/network/Github.dart';
import 'package:LoginUI/ui/base/BaseStatefulState.dart';
import 'package:LoginUI/ui/data/User.dart';
import 'package:LoginUI/utils/RepoListProvider.dart';
import 'package:LoginUI/userprofile/UserProfilePage.dart';
import 'package:LoginUI/utils/SharedPrefs.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UserProfileState extends BaseStatefulState<UserProfilePage> {

  final User user;

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
      title: new Text(
        user.login,
        textDirection: TextDirection.ltr,
      ),
    );
  }

  header() {
    return new Row(children: <Widget>[userImage(), bio()]);
  }

  bio() {
    return new Expanded(
      child: new Container(
        width: 300.0,
        height: 160.0,
        margin: const EdgeInsets.only(
            top: 30.0, left: 10.0, right: 20.0, bottom: 30.0),
        decoration:
            new BoxDecoration(border: new Border.all(color: Colors.indigo)),
        child: new Text(getBioText()),
      ),
    );
  }

  String getBioText() {
    if (user.bio == null || user.bio.isEmpty) {
      return "No Description.";
    } else {
      return user.bio;
    }
  }

  /*
  * returns circular profile image of user
  */
  userImage() {
    return new Column(
      children: <Widget>[
        new Container(
            width: 80.0,
            height: 80.0,
            margin: const EdgeInsets.only(left: 10.0),
            decoration: new BoxDecoration(
                shape: BoxShape.circle,
                image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: new NetworkImage(user.avatarUrl)))),
        new Text(
          user.login,
          textDirection: TextDirection.ltr,
        )
      ],
    );
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
