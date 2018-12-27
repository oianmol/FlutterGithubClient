import 'package:LoginUI/ui/repodetails/RepoDetailsPageState.dart';
import 'package:flutter/material.dart';

class RepoDetailsPage extends StatefulWidget {
  String repoId;
  String loginName;

  RepoDetailsPage(String loginName,String repoId, {Key key}) : super(key: key){
    this.repoId = repoId;
    this.loginName = loginName;
  }

  @override
  RepoDetailsPageState createState() => new RepoDetailsPageState(loginName,repoId);
}