import 'dart:async';
import 'dart:convert';

import 'package:LoginUI/model/GistModel.dart';
import 'package:LoginUI/network/Github.dart';
import 'package:LoginUI/ui/base/BaseStatefulState.dart';
import 'package:LoginUI/ui/usergists/UserGistsPage.dart';
import 'package:LoginUI/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:http/src/response.dart';

class UserGistsPageState extends BaseStatefulState<UserGistsPage>
    with TickerProviderStateMixin {
  double USER_IMAGE_SIZE = 200.0;

  List<GistModel> gists;
  StreamSubscription<Response> subscription;
  ScrollController scrollController;
  var page = 1;
  String loginName;

  String accessToken;

  UserGistsPageState(@required this.loginName);

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(_scrollListener);
    SharedPrefs().getToken().then((token) {
      accessToken = token;
      getGists();
    });
  }

  @override
  void dispose() {
    if (subscription != null) {
      subscription.cancel();
    }
    scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget prepareWidget(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        body: new Column(
          children: <Widget>[toolbarAndroid(), listVIew()],
        ));
  }

  toolbarAndroid() {
    return new AppBar(
      backgroundColor: Colors.black,
      centerTitle: false,
      title: Text("$loginName's Gist's"),
    );
  }

  listVIew() {
    return new Expanded(
        child: new ListView.builder(
            controller: scrollController,
            padding: new EdgeInsets.all(8.0),
            itemCount: gists == null ? 0 : gists.length,
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                child: new Row(
                  children: <Widget>[
                    new Container(
                      child: new Image.network(gists[index].owner.avatarUrl,
                          width: 50.0, height: 50.0),
                      padding: EdgeInsets.all(10),
                    ),
                    new Container(
                        margin: EdgeInsets.all(10),
                        child: new Text('${gists[index].files.gistFile.first.filename}'))
                  ],
                ),
                onTap: () => moveToGistDetailScreen(gists[index]),
              );
            }));
  }

  moveToGistDetailScreen(GistModel gist) {
    /* Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>),
    );*/
  }

  void _scrollListener() {
    print(scrollController.position.extentAfter);
    if (scrollController.position.extentAfter == 0 && gists != null) {
      if (subscription == null) {
        getGists();
      }
    }
  }

  void getGists() {
    showProgress();
    if (subscription != null) {
      subscription.cancel();
    }
    subscription = Github.getGistsForUser(loginName, 10,page)
        .asStream()
        .listen((response) {
      this.setState(() {
        if (this.gists == null) {
          this.gists = parseGists(response.body);
        } else {
          this.gists.addAll(parseGists(response.body));
        }
      });
      page = page + 1;
      hideProgress();
      subscription = null;
    });
  }
}

// A function that will convert a response body into a List<User>
List<GistModel> parseGists(String responseBody) {
  var gists = json.decode(responseBody) as List;
  var gistsList = List<GistModel>();
  gists.forEach((json) {
    gistsList.add(GistModel.fromJson(json));
  });
  return gistsList;
}
