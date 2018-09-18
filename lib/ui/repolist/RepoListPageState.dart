import 'dart:async';
import 'dart:convert';

import 'package:LoginUI/network/Github.dart';
import 'package:LoginUI/ui/base/BaseStatefulState.dart';
import 'package:LoginUI/ui/repolist/RepoListPage.dart';
import 'package:LoginUI/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:http/src/response.dart';

class RepoListPageState extends BaseStatefulState<RepoListPage>
    with TickerProviderStateMixin {
  List<dynamic> repos;
  Widget appBarTitle = new Text("My Repos");

  String accessToken;

  StreamSubscription<Response> subscriptionMyRepos;

  @override
  void initState() {
    super.initState();
    SharedPrefs().getToken().then((token) {
      accessToken = token;
      getMyRepos();
    });
  }

  @override
  Widget prepareWidget(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
        key: scaffoldKey,
        body: new Column(
          children: <Widget>[toolbarAndroid(), listVIew()],
        ));
  }

  listVIew() {
    return new Expanded(
        child: new ListView.builder(
            padding: new EdgeInsets.all(8.0),
            itemCount: repos == null ? 0 : repos.length,
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 5.0, left: 5.0, right: 5.0),
                child: new Column(children: <Widget>[
                  new Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 5.0, left: 5.0),
                    child: new Text('${repos[index]['name']}',
                        style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 18.0,
                            color: Colors.green)),
                  ),
                  new Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: 5.0, left: 5.0),
                    child: new Text(
                        'Repo Type: ${(repos[index]['private'] as bool) ? "Private" : "Public"}',
                        style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 14.0,
                            color: Colors.blueGrey)),
                  )
                ]),
              );
            }));
  }

  toolbarAndroid() {
    return new AppBar(
      centerTitle: false,
      title: appBarTitle,
    );
  }

  getMyRepos() {
    hideProgress();
    if (subscriptionMyRepos != null) {
      subscriptionMyRepos.cancel();
    }
    showProgress();
    var stream = Github.getAllMyRepos(accessToken).asStream();
    subscriptionMyRepos = stream.listen((response) {
      this.setState(() {
        print(response.body);
        repos = json.decode(response.body) as List;
        print(repos);
        //print(getUserResponse);
      });
      hideProgress();
    });
  }
}
