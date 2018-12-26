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
  StreamSubscription<Response> subscriptionMyRepos;

  List<ReposModel> repos;
  int page = 1;

  ScrollController scrollController;

  RepoListProvider repoListProvider;

  @override
  void initState() {
    super.initState();
    repoListProvider = new RepoListProvider();
    scrollController = new ScrollController();
    scrollController.addListener(_scrollListener);
    SharedPrefs().getToken().then((token) {
      accessToken = token;
      getMyRepos();
    });
  }

  @override
  void dispose() {
    if (subscriptionMyRepos != null) {
      subscriptionMyRepos.cancel();
    }
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    print(scrollController.position.extentAfter);
    if (scrollController.position.extentAfter == 0 && repos != null) {
      if (subscriptionMyRepos == null) {
        getMyRepos();
      }
    }
  }

  @override
  Widget prepareWidget(BuildContext context) {
    var uiElements = <Widget>[];
    uiElements.add(toolbarAndroid());
    if (repos != null) {
      uiElements.add(new Expanded(
          child:
              repoListProvider.getReposList(repos, false, scrollController)));
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
    subscriptionMyRepos =
        repoListProvider.getMyRepos(page, 10, accessToken, (repos) {
      this.setState(() {
        if (this.repos == null) {
          this.repos = repos;
        } else {
          this.repos.addAll(repos);
        }
      });
      page = page + 1;
      hideProgress();
      subscriptionMyRepos = null;
    });
  }
}
