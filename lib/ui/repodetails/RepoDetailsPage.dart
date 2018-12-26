import 'package:LoginUI/ui/repodetails/RepoDetailsPageState.dart';
import 'package:flutter/material.dart';

class RepoDetailsPage extends StatefulWidget {
  String repoId;

  RepoDetailsPage(String repoId, {Key key}) : super(key: key){
    this.repoId = repoId;
  }

  @override
  RepoDetailsPageState createState() => new RepoDetailsPageState(repoId);
}