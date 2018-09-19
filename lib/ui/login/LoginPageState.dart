import 'dart:async';
import 'dart:convert';

import 'package:LoginUI/network/Github.dart';
import 'package:LoginUI/ui/base/BaseStatefulState.dart';
import 'package:LoginUI/ui/dashboard/DashboardPage.dart';
import 'package:LoginUI/ui/login/LoginPage.dart';
import 'package:LoginUI/utils/SharedPrefs.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/src/response.dart';
import 'package:vector_math/vector_math_64.dart' as Vector;

class LoginPageState extends BaseStatefulState<LoginPage>
    with TickerProviderStateMixin {
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

  String username = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    SharedPrefs().getToken().then((value) {
      if (value != null && value.isNotEmpty) {
        debugPrint("fetched SharedPrefrences $value");
        fetchedAccessToken();
      } else {
        _focusNode = new FocusNode();
        startTime();
      }
    });
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
  Widget prepareWidget(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    centerValue = MediaQuery.of(context).size.height / 2;
    centerValue = centerValue - (LOGO_SIZE / 2);

    return new Scaffold(
        key: scaffoldKey,
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
            passwordWidget(context),
            forgotPassword(context),
            loginButton(context),
            loginOauthButton(context)
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
            onPressed: loginNowBasic,
            textColor: Colors.white,
            child: new Text(
              "Login",
              style: TextStyle(fontSize: 20.0),
            )));
  }

  loginOauthButton(BuildContext context) {
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
              "Login via Browser?",
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
            username = inputText;
            FocusScope.of(context).requestFocus(_focusNode);
          },
          decoration: InputDecoration(
              hintText: 'Email',
              contentPadding: EdgeInsets.all(10.0),
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5))),
        ));
  }

  passwordWidget(BuildContext context) {
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
          onFieldSubmitted: (String passwordText) {
            password = passwordText;
          },
          style: TextStyle(color: Colors.white, fontSize: 20.0),
          decoration: InputDecoration(
              hintText: 'Password',
              contentPadding: EdgeInsets.all(10.0),
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.5))),
        ),
        margin: EdgeInsets.all(8.0));
  }

  loginNowBasic() async {
    showProgress();
    Github.authenticateUsernamePassword(username, password).then((response) {
      print(response.body);
      var token = json.decode(response.body)['token'];
      print(token);
      SharedPrefs().saveToken("access_token=$token");
      hideProgress();
      fetchedAccessToken();
    });
  }

  loginNow() async {
    showProgress();
    Github.authenticate((token) {
      SharedPrefs().saveToken(token);
      hideProgress();
      fetchCurrentUserProfile(token);
      fetchedAccessToken();
    });
  }

  void fetchedAccessToken() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DashboardPage()),
    );
  }

  void fetchCurrentUserProfile(String token) {
    // Github.getMyUserProfile(token);

    var stream = Github.getMyUserProfile(token).asStream();
    StreamSubscription<Response> subscription = stream.listen((response) {
      this.setState(() {
        SharedPrefs().saveCurrentUserProfile(response.body);
        final currentUser = json.decode(response.body);
        print("Current User Profile: $currentUser");
        
        // getUserResponse = json.decode(response.body);
        // users = getUserResponse['items'] as List;
        // print(users);
        //print(getUserResponse);
      });
      hideProgress();
    });
  }
}
