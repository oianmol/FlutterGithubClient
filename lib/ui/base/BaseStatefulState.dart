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

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return prepareWidget(context);
  }

  void showProgress() {
    if(!isVisible){
      scaffoldKey.currentState.showSnackBar(snackBar);
    }
    isVisible = true;
  }

  void hideProgress() {
    if(isVisible){
      scaffoldKey.currentState.hideCurrentSnackBar();
    }
    isVisible = false;
  }

  Widget prepareWidget(BuildContext context);
}
