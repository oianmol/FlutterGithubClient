import 'package:LoginUI/network/Github.dart';
import 'package:LoginUI/ui/UserScreen.dart';
import 'package:flutter/material.dart';

class UserScreenState extends State<UserScreen> with TickerProviderStateMixin {
  double USER_IMAGE_SIZE = 200.0;

  String getUserResponse;

  @override
  void initState() {
    super.initState();

    Github.getUser(widget.data).then((response){
      this.setState((){
        getUserResponse  = response.body;
        print(getUserResponse);
      });
    });
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
        body: new Stack(
      children: <Widget>[userImage(), userName()],
    ));
  }

  userImage() {
    return new Image.network("https://images.pexels.com/photos/67636/rose-blue-flower-rose-blooms-67636.jpeg?auto=compress&cs=tinysrgb&h=350",
        width: USER_IMAGE_SIZE, height: USER_IMAGE_SIZE, color: Colors.white);
  }

  userName() {
    return new Container(
      child: new Text("User Name"),
      color: Colors.white,
      margin: EdgeInsets.all(20.0),
    );
  }
}
