import 'package:LoginUI/model/ReposModel.dart';
import 'package:LoginUI/ui/base/BaseStatefulState.dart';
import 'package:LoginUI/ui/repodetails/RepoDetailsPage.dart';
import 'package:LoginUI/utils/RepoListProvider.dart';
import 'package:LoginUI/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';

class RepoDetailsPageState extends BaseStatefulState<RepoDetailsPage>
    with TickerProviderStateMixin {

  var repoName = "My Repo";

  String accessToken;

  var repoId;

  ReposModel repoModel;

  RepoDetailsPageState(String repoId){
    this.repoId = repoId;
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
  Widget prepareWidget(BuildContext context) {
    var uiElements = <Widget>[];
    uiElements.add(toolbarAndroid());
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
    repoModel = RepoListProvider.getRepoDetails(repoId);
      setState(() {
        repoName = repoModel.name;
      });
  }
}
