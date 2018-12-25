import 'dart:async';
import 'dart:convert';

import 'package:LoginUI/model/UserProfile.dart';
import 'package:LoginUI/network/Github.dart';
import 'package:LoginUI/ui/base/BaseStatefulState.dart';
import 'package:LoginUI/ui/searchusers/UserSearchPage.dart';
import 'package:LoginUI/userprofile/UserProfilePage.dart';
import 'package:LoginUI/utils/SharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:http/src/response.dart';

class UserSearchPageState extends BaseStatefulState<UserSearchPage>
    with TickerProviderStateMixin {
  double USER_IMAGE_SIZE = 200.0;

  dynamic getUserResponse;
  List<UserProfile> users;
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Search Github Users...");

  StreamSubscription<Response> subscription;

  String accessToken;

  ScrollController scrollController;

  var page = 1;

  String searchString;

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(_scrollListener);
    SharedPrefs().getToken().then((token) {
      accessToken = token;
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
            controller: scrollController,
            padding: new EdgeInsets.all(8.0),
            itemCount: users == null ? 0 : users.length,
            itemBuilder: (BuildContext context, int index) {
              return new GestureDetector(
                child: new Row(
                  children: <Widget>[
                    new Container(
                      child: new Image.network(users[index].avatarUrl,
                          width: 50.0, height: 50.0),
                      padding: EdgeInsets.all(10),
                    ),
                    new Container(
                        margin: EdgeInsets.all(10),
                        child: new Text('${users[index].login}'))
                  ],
                ),
                onTap: () => moveToUserScreen(users[index]),
              );
            }));
  }

  moveToUserScreen(UserProfile user) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserProfilePage(user)),
    );
  }

  toolbarAndroid() {
    return new AppBar(
      centerTitle: false,
      backgroundColor: Colors.black,
      title: appBarTitle,
      actions: <Widget>[
        new IconButton(icon: actionIcon, onPressed: () => onClickToolbar())
      ],
    );
  }

  searchUser(String string) {
    if(this.searchString!=null && searchString.compareTo(string)!=0){
      setState(() {
        page = 1;
        this.users = null;
      });
    }
    this.searchString = string;
    if (subscription != null) {
      subscription.cancel();
    }
    showProgress();
    var stream = Github.getUsersBySearch(accessToken, string, page).asStream();
    subscription = stream.listen((response) {
      print("Response " + response.body);
      var parsedData = json.decode(response.body);
      if (parsedData['message'].toString() != "Validation Failed") {
        setState(() {
          if (users == null) {
            users = parseUsers(response.body);
          } else {
            users.addAll(parseUsers(response.body));
          }
          page = page + 1;
        });
      }
      hideProgress();
      subscription = null;
    });
  }

  onClickToolbar() {
    setState(() {
      if (this.actionIcon.icon == Icons.search) {
        this.actionIcon = new Icon(Icons.close);
        this.appBarTitle = new TextField(
          onChanged: (string) => searchUser(string),
          style: new TextStyle(
            color: Colors.white,
          ),
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search, color: Colors.white),
              hintText: "Search...",
              hintStyle: new TextStyle(color: Colors.white)),
        );
      } else {
        this.actionIcon = new Icon(Icons.search);
        if(this.subscription!=null){
          this.subscription.cancel();
        }
        this.users = null;
        this.appBarTitle = new Text("Search Github Users...");
      }
    });
  }

  void _scrollListener() {
    print(scrollController.position.extentAfter);
    if (scrollController.position.extentAfter == 0) {
      if (subscription == null) {
        searchUser(searchString);
      }
    }
  }
}

// A function that will convert a response body into a List<User>
List<UserProfile> parseUsers(String responseBody) {
  var parsedData = json.decode(responseBody);
  var users = parsedData['items'] as List<dynamic>;
  var userProfiles = new List<UserProfile>();
  users.forEach((object) {
    print(object);
    userProfiles.add(UserProfile.fromJson(object));
  });
  return userProfiles;
}
