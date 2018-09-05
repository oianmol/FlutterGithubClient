import 'dart:async';

import 'package:LoginUI/network/Github.dart';
import 'package:LoginUI/ui/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as Vector;

class LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<EditableTextState> _emailState =
      new GlobalKey<EditableTextState>();
  final GlobalKey<EditableTextState> _passwordState =
      new GlobalKey<EditableTextState>();

  FocusNode _focusNode;
  double centerValue;
  double LOGO_SIZE = 200.0;

  bool splashVisible = true;
  bool animateLogo = false;
  bool formVisible = false;

  @override
  void initState() {
    super.initState();
    _focusNode = new FocusNode();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, switchState);
  }

  void switchState() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      splashVisible = false;
      animateLogo = true;
      formVisible = true;
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
    centerValue = MediaQuery.of(context).size.height / 2;
    centerValue = centerValue - (LOGO_SIZE / 2);
    return new Scaffold(
        key: _scaffoldKey,
        body: new Stack(
          children: <Widget>[
            blurMask(context),
            splashScreen(context),
            logoCenter(context)
          ],
        ));
  }

  getEndOffset() {
    return Offset(0.0, 1.0);
  }

  getBeginOffset() {
    return Offset(0.5, 0.5);
  }

  splashScreen(BuildContext context) {
    return new AnimatedOpacity(
        opacity: splashVisible ? 1.0 : 0.0,
        duration: new Duration(seconds: 2),
        child: new Container(
            color: Colors.blue,
            height: double.infinity,
            width: double.infinity));
  }

  blurMask(BuildContext context) {
    return new Container(
        color: Colors.blueGrey,
        height: double.infinity,
        width: double.infinity);
  }

  logoCenter(BuildContext context) {
    return new AnimatedContainer(
        child: aesLogoLoginForm(context),
        curve: Curves.linear,
        duration: Duration(seconds: 1),
        transform: new Matrix4.translation(
            new Vector.Vector3(0.0, animateLogo ? 50.0 : centerValue, 0.0)));
  }

  aesLogoLoginForm(BuildContext context) {
    return new Column(
      children: <Widget>[aesLogo(), loginForm(context)],
    );
  }

  aesLogo() {
    return new FlutterLogo(size: LOGO_SIZE);
  }

  loginForm(BuildContext context) {
    return new AnimatedOpacity(
        opacity: formVisible ? 1.0 : 0.0,
        duration: new Duration(seconds: 3),
        child: new Container(
          margin: const EdgeInsets.only(top: 20.0),
          child: new Column(children: <Widget>[
            email(context),
            password(context),
            forgotPassword(context),
            loginButton(context)
          ]),
        ));
  }

  loginButton(BuildContext context) {
    return new Container(
        margin: EdgeInsets.all(16.0),
        foregroundDecoration: ShapeDecoration.fromBoxDecoration(BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(4.0)))),
        alignment: Alignment.center,
        child: new MaterialButton(
            onPressed: loginNow,
            textColor: Colors.white,
            child: new Text(
              "Login",
              style: TextStyle(fontSize: 20.0),
            )));
  }

  forgotPassword(BuildContext context) {
    return new Container(
        margin: EdgeInsets.all(14.0),
        alignment: Alignment.centerLeft,
        child: new Text("Forgot User ID or Password?",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
            maxLines: 1,
            textAlign: TextAlign.start));
  }

  email(BuildContext context) {
    return new Container(
        margin: EdgeInsets.all(8.0),
        child: new TextFormField(
          key: _emailState,
          maxLines: 1,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          keyboardAppearance: Brightness.light,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
          onFieldSubmitted: (String inputText) {
            FocusScope.of(context).requestFocus(_focusNode);
          },
          decoration: InputDecoration(
              hintText: 'Email',
              contentPadding: EdgeInsets.all(10.0),
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5))),
        ));
  }

  password(BuildContext context) {
    return new Container(
        child: new TextFormField(
          key: _passwordState,
          focusNode: _focusNode,
          maxLines: 1,
          autocorrect: false,
          obscureText: true,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          keyboardAppearance: Brightness.light,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
          decoration: InputDecoration(
              hintText: 'Password',
              contentPadding: EdgeInsets.all(10.0),
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5))),
        ),
        margin: EdgeInsets.all(8.0));
  }

  loginNow() async {
    /* Apis.fetchPost().then((response) {
      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");
      _scaffoldKey.currentState.showBottomSheet<Null>((BuildContext context) {
        return new Container(
            child: new Text(response.body), margin: EdgeInsets.all(4.0));
      });
    }).catchError((error) {
      print("Error body: $error");
    }).whenComplete(() {});*/

    showProgressBar();
    Github.authenticate((success){
      _scaffoldKey.currentState.hideCurrentSnackBar();
      _scaffoldKey.currentState.showBottomSheet<Null>((BuildContext context) {
        return new Container(
            child: new Text("Authenticated to Github!"+success), margin: EdgeInsets.all(4.0));
      });
    });
  }

  void showProgressBar() {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Row(
        children: <Widget>[
          new Container(
              child: new CircularProgressIndicator(),
              margin: EdgeInsets.all(4.0)),
          new Container(
              child: new Text("Authenticating..."), margin: EdgeInsets.all(4.0)),
        ],
      ),
    ));
  }
}
