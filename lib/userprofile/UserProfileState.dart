import 'dart:async';
import 'dart:convert';

import 'package:LoginUI/network/Github.dart';
import 'package:LoginUI/ui/base/BaseStatefulState.dart';
import 'package:LoginUI/ui/data/User.dart';
import 'package:LoginUI/userprofile/UserProfilePage.dart';
import 'package:LoginUI/utils/SharedPrefs.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UserProfileState extends BaseStatefulState<UserProfilePage> {

  final User user;

  StreamSubscription<Response> subscriptionRepos;
  String accessToken;
  List<dynamic> repos;


  UserProfileState(@required this.user);


  @override
  void initState() {
    super.initState();
    SharedPrefs().getToken().then((token) {
      accessToken = token;
      print(user);
     getRepos();
    });
  }

  @override
  Widget prepareWidget(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: toolbarAndroid(),
      body: new Column(
        children: <Widget>[header(), listVIew()],
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

  getRepos() {
    hideProgress();
    if (subscriptionRepos != null) {
      subscriptionRepos.cancel();
    }
    showProgress();
    var stream = Github.getUserRepos(accessToken, user.login).asStream();
    subscriptionRepos = stream.listen((response) {
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
