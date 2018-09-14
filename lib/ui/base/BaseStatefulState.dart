import 'package:flutter/material.dart';

abstract class BaseStatefulState<StatefulWidget> extends State {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final SnackBar snackBar = new SnackBar(
    content: new Row(
      children: <Widget>[
        new Container(
            child: new CircularProgressIndicator(),
            margin: EdgeInsets.all(4.0)),
        new Container(
            child: new Text("Loading..."), margin: EdgeInsets.all(4.0)),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return prepareWidget(context);
  }

  void showProgress() {
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void hideProgress() {
    scaffoldKey.currentState.hideCurrentSnackBar();
  }

  Widget prepareWidget(BuildContext context);
}
