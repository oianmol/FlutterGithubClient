import 'dart:async';
import 'dart:convert';

import 'package:LoginUI/model/ContributorsModel.dart';
import 'package:LoginUI/model/ReposModel.dart';
import 'package:LoginUI/network/Github.dart';
import 'package:LoginUI/ui/base/BaseStatefulState.dart';
import 'package:LoginUI/ui/repodetails/RepoDetailsPage.dart';
import 'package:LoginUI/userprofile/UserProfilePage.dart';
import 'package:LoginUI/utils/RepoListProvider.dart';
import 'package:LoginUI/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:http/src/response.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoDetailsPageState extends BaseStatefulState<RepoDetailsPage>
    with TickerProviderStateMixin {
  var repoName = "My Repo";

  String accessToken;

  String repoId;
  String loginName;

  ReposModel repoModel;

  StreamSubscription<Response> subscriptionContributors;

  List<ContributorsModel> contributorsModel = new List<ContributorsModel>();

  StreamSubscription<Response> subscriptionRepoDetails;


  RepoDetailsPageState(String loginName,String repoId) {
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
    if(subscriptionRepoDetails!=null){
      subscriptionRepoDetails.cancel();
    }
    super.dispose();
  }

  @override
  Widget prepareWidget(BuildContext context) {
    var uiElements = <Widget>[];
    uiElements.add(toolbarAndroid());
    if (repoModel != null) {
      uiElements.add(repoDetailView());
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
      title: new Text(repoName),
    );
  }

  void getMyRepoDetails() {
    if(subscriptionRepoDetails!=null){
      subscriptionRepoDetails.cancel();
    }
   subscriptionRepoDetails =  Github.getApiForUrl(Github.getUserRepoGithub.replaceFirst(Github.USER, loginName).replaceFirst(Github.REPO, repoId)).asStream().listen((repo){
      print(repo.body.toString());
      repoModel = ReposModel.fromJson(json.decode(repo.body));
      repoName = repoModel.name;
      setState(() {
      });
      getContributors();
    });
  }

  Widget repoDetailView() {
    return new CustomScrollView(
      shrinkWrap: true,
      slivers: [
        new SliverList(
          delegate: new SliverChildListDelegate(<Widget>[getRepoDetails()]),
        ),
      ],
    );
  }

  void getContributors() {
    if (subscriptionContributors != null) {
      subscriptionContributors.cancel();
    }
    if (repoModel != null && repoModel.contributorsUrl != null) {
      subscriptionContributors = Github.getApiForUrl(repoModel.contributorsUrl)
          .asStream()
          .listen((result) {
        var list = json.decode(result.body) as List;
        list.forEach((item) {
          this.contributorsModel.add(ContributorsModel.fromJson(item));
        });
        setState(() {});
      });
    }
  }

  Column getRepoDetails() {
    var listWidgets = List<Widget>();

    listWidgets
        .add(Image.network(repoModel.owner.avatarUrl, width: 40, height: 40));
    listWidgets.add(Container(
        child: Text(
          repoModel.fullName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        padding: EdgeInsets.all(4.0)));
    listWidgets.add(Container(
      child: Text("Language: " + repoModel.language),
      padding: EdgeInsets.all(4.0),
    ));
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
    listWidgets.add(Container(
      child: Text(
        "Contributors:",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      padding: EdgeInsets.all(4.0),
    ));
    listWidgets.add(getContributorsList());

    return Column(children: listWidgets);
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

  getContributorsList() {
    if (contributorsModel != null) {
      return ListView.builder(
          padding: new EdgeInsets.all(8.0),
          itemCount: contributorsModel == null ? 0 : contributorsModel.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return new GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfilePage(
                            this.contributorsModel.elementAt(index).login)),
                  );
                },
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child: new Image.network(
                          '${contributorsModel.elementAt(index).avatarUrl}',
                          width: 40.0,
                          height: 40.0),
                      padding: EdgeInsets.all(10),
                    ),
                    getDetailView(contributorsModel.elementAt(index))
                  ],
                ));
          });
    }
  }
}
