import 'dart:async';

import 'package:LoginUI/model/ReposModel.dart';
import 'package:LoginUI/ui/base/BaseStatefulState.dart';
import 'package:LoginUI/ui/repolist/RepoListPage.dart';
import 'package:LoginUI/utils/RepoListProvider.dart';
import 'package:LoginUI/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:http/src/response.dart';

class RepoListPageState extends BaseStatefulState<RepoListPage>
    with TickerProviderStateMixin {
  Widget appBarTitle = new Text("My Repos");

  String accessToken;
  RepoListProvider repoListProvider;
  StreamSubscription<Response> subscriptionMyRepos;

  List<ReposModel> repos;

  @override
  void initState() {
    super.initState();
    repoListProvider = new RepoListProvider();
    SharedPrefs().getToken().then((token) {
      accessToken = token;
      getMyRepos();
    });
  }

  @override
  Widget prepareWidget(BuildContext context) {
    var uiElements = <Widget>[];
    uiElements.add(toolbarAndroid());
    if(repos!=null){
      uiElements.add(new Expanded(child: repoListProvider.getReposList(repos,false)));
    }

    return new Scaffold(
        key: scaffoldKey,
        body: new Column(
          children: uiElements,
        ));
  }

  toolbarAndroid() {
    return new AppBar(
      backgroundColor: Colors.black,
      centerTitle: false,
      title: appBarTitle,
    );
  }

  getMyRepos() {
    showProgress();
    if (subscriptionMyRepos != null) {
      subscriptionMyRepos.cancel();
    }
    subscriptionMyRepos = repoListProvider.getMyRepos(accessToken, (repos) {
      this.setState(() {
        this.repos = repos;
      });
      hideProgress();
    });
  }
}
