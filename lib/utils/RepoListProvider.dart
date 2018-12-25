import 'dart:async';
import 'dart:convert';

import 'package:LoginUI/network/Github.dart';
import 'package:flutter/material.dart';
import 'package:http/src/response.dart';

class RepoListProvider {

  RepoListProvider() {}

  List<Widget> reposList(List<dynamic> repos, String title) {
    return [
      new Container(child:
      new Text(title, style: new TextStyle(fontStyle: FontStyle.italic,fontSize: 18),
          textAlign: TextAlign.start),
        padding: EdgeInsets.only(left: 15,top: 15),alignment: Alignment.centerLeft),
      new ListView.builder(
          padding: new EdgeInsets.all(8.0),
          itemCount: repos == null ? 0 : repos.length,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
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
          })];
  }

  StreamSubscription getMyRepos(String accessToken, Function func) {
    var stream = Github.getAllMyRepos(accessToken).asStream();
    return stream.listen((response) {
      var repos = json.decode(response.body) as List;
      print(repos);
      func(repos);
    });
  }

  StreamSubscription<Response> getUserRepos(
      String accessToken, String login, Function func) {
    var stream = Github.getUserRepos(accessToken, login).asStream();
    return stream.listen((response) {
      var repos = json.decode(response.body) as List;
      print(repos);
      func(repos);
    });
  }

  StreamSubscription<Response> getStarredRepos(String username, Function func) {
    var stream = Github.getUserStarredRepos(username).asStream();
    return stream.listen((response) {
      var repos = json.decode(response.body) as List;
      print(repos);
      func(repos);
    });
  }
}
