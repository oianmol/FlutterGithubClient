import 'package:LoginUI/network/Github.dart';
import 'package:LoginUI/ui/UserScreen.dart';
import 'package:flutter/material.dart';

class UserScreenState extends State<UserScreen> with TickerProviderStateMixin {
  double USER_IMAGE_SIZE = 200.0;

  String getUserResponse;
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Search Github Users...");
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return new Scaffold(
        body: new Column(
      children: <Widget>[toolbarAndroid(), userImage(), userName()],
    ));
  }

  userImage() {
    return new Image.network(
        "https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&h=350",
        width: USER_IMAGE_SIZE,
        height: USER_IMAGE_SIZE,
        color: Colors.white);
  }

  userName() {
    return new Container(
      child: new Text(getUserResponse != null ? getUserResponse : ""),
      color: Colors.white,
      margin: EdgeInsets.all(20.0),
    );
  }

  toolbarAndroid() {
    return new AppBar(
      centerTitle: false,
      title: appBarTitle,
      actions: <Widget>[
        new IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextField(
                    onChanged: (string){
                      searchUser(widget,string);
                    },
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
                  this.appBarTitle = new Text("Search Github Users...");
                }
              });
            })
      ],
    );
  }

  searchUser(UserScreen widget, String string) {
    Github.getUsersBySearch(widget.data,
        string).then((response) {
      this.setState(() {
        getUserResponse = response.body;
        print(getUserResponse);
      });
    });
  }
}
