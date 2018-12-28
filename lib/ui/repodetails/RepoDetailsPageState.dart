import 'dart:async';
import 'dart:convert';

import 'package:LoginUI/model/ContributorsModel.dart';
import 'package:LoginUI/model/ReposModel.dart';
import 'package:LoginUI/network/Github.dart';
import 'package:LoginUI/ui/base/BaseStatefulState.dart';
import 'package:LoginUI/ui/repodetails/RepoDetailsPage.dart';
import 'package:LoginUI/userprofile/UserProfilePage.dart';
import 'package:LoginUI/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:http/src/response.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoDetailsPageState extends BaseStatefulState<RepoDetailsPage>
    with TickerProviderStateMixin {
  String accessToken;

  String repoId;
  String loginName;

  ReposModel repoModel;

  StreamSubscription<Response> subscriptionContributors;

  List<ContributorsModel> contributorsModel = new List<ContributorsModel>();

  StreamSubscription<Response> subscriptionRepoDetails;

  RepoDetailsPageState(String loginName, String repoId) {
    this.repoId = repoId;
    this.loginName = loginName;
  }

  @override
  void initState() {
    super.initState();
    SharedPrefs().getToken().then((token) {
      accessToken = token;
      getMyRepoDetails();
    });
  }

  @override
  void dispose() {
    if (subscriptionContributors != null) {
      subscriptionContributors.cancel();
    }
    if (subscriptionRepoDetails != null) {
      subscriptionRepoDetails.cancel();
    }
    super.dispose();
  }

  @override
  Widget prepareWidget(BuildContext context) {
    var uiElements = <Widget>[];
    uiElements.add(toolbarAndroid());
    if (repoModel != null) {
      print(repoModel.toJson().toString());
      uiElements.add(getRepoDetails());
    }
    if (contributorsModel.isNotEmpty) {
      uiElements.add(getContributorsList());
    }
    return new Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black54,
        body: new CustomScrollView(
          slivers: [
            new SliverList(
              delegate: new SliverChildListDelegate(uiElements),
            ),
          ],
        ));
  }

  toolbarAndroid() {
    return new AppBar(
      backgroundColor: Colors.black,
      centerTitle: false,
      title: new Text(repoId),
    );
  }

  void getMyRepoDetails() {
    if (subscriptionRepoDetails != null) {
      subscriptionRepoDetails.cancel();
    }
    showProgress();
    subscriptionRepoDetails = Github.getApiForUrl(Github.getUserRepoGithub
            .replaceFirst(Github.USER, loginName)
            .replaceFirst(Github.REPO, repoId),accessToken)
        .asStream()
        .listen((repo) {
          print(json.decode(repo.body));
      repoModel = ReposModel.fromJson(json.decode(repo.body));
      setState(() {});
      hideProgress();
      getContributors();
    });
  }

  void getContributors() {
    if (subscriptionContributors != null) {
      subscriptionContributors.cancel();
    }
    if (repoModel != null && repoModel.contributorsUrl != null) {
      showProgress();
      subscriptionContributors = Github.getApiForUrl(repoModel.contributorsUrl,accessToken)
          .asStream()
          .listen((result) {
        var list = json.decode(result.body) as List;
        list.forEach((item) {
          this.contributorsModel.add(ContributorsModel.fromJson(item));
        });
        setState(() {});
        hideProgress();
      });
    }
  }

  Widget getRepoDetails() {
    var listWidgets = List<Widget>();

    listWidgets.add(Container(
        margin: EdgeInsets.all(8),
        child:
            Image.network(repoModel.owner.avatarUrl, width: 80, height: 80)));
    listWidgets.add(Container(
        child: Text(
          repoModel.fullName,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        padding: EdgeInsets.all(4.0)));

    if(repoModel.language.isNotEmpty){
      listWidgets.add(Container(
        child: Text("Language: " + repoModel.language),
        padding: EdgeInsets.all(4.0),
      ));
    }

    listWidgets.add(Container(
      child: Text("Issues: " + repoModel.openIssuesCount.toString()),
      padding: EdgeInsets.all(4.0),
    ));
    listWidgets.add(Container(
      child: Text("Stars: " + repoModel.stargazersCount.toString()),
      padding: EdgeInsets.all(4.0),
    ));
    listWidgets.add(Container(
      child: Text("Default Branch: " + repoModel.defaultBranch),
      padding: EdgeInsets.all(4.0),
    ));
    listWidgets.add(Container(
      child: InkWell(
        onTap: () => launch(repoModel.htmlUrl),
        child: Text("Github URL: " + repoModel.htmlUrl),
      ),
      padding: EdgeInsets.all(4.0),
    ));

    return Center(child: Card(child: Column(children: listWidgets)));
  }

  getDetailView(ContributorsModel repo) {
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            '${repo.login}',
            style: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 16.0,
                color: Colors.black),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          new Text('Site Admin: ${(repo.siteAdmin) ? "Yes" : "No"}',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 14.0,
                  color: Colors.black87),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis)
        ]);
  }

  Widget getContributorsList() {
    var list = List<Widget>();
    if (contributorsModel != null) {
      list.add(Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.all(5),
        child: Text(
          "Contributors:",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        padding: EdgeInsets.all(4.0),
      ));
      contributorsModel.forEach((item) {
        list.add(GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserProfilePage(item.login)),
              );
            },
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Container(
                  child: new Image.network('${item.avatarUrl}',
                      width: 40.0, height: 40.0),
                  padding: EdgeInsets.all(10),
                ),
                getDetailView(item)
              ],
            )));
      });
    }
    return Center(child: Card(child: Column(children: list),margin: EdgeInsets.all(18),));
  }
}
